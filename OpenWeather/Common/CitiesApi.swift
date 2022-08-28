//
//  CitiesApi.swift
//  OpenWeather
//
//  Created by Алексей Рябин on 23.07.2022.
//

import Foundation
import Combine
import FileProvider

protocol CitiesApiDelegate{
    var lang: String {get set}
    func getCities(countryCode: String, completion: @escaping ([City]?)->Void)
}

class CitiesApi: CitiesApiDelegate{
    private let url = "https://wft-geo-db.p.rapidapi.com/v1/geo/cities"
    private let apiKey = "8759eb194bmsh2abec209160e84ep17a6b2jsn42a5325a2f63"
    var lang = "en"
    private let maxCitiesInResult = 10
    private var citiesAccepted = 0
    
    init(){
        self.lang = Locale.current.languageCode ?? "en"
    }
    
    init(language: String){
        self.lang = language
    }
    private let requestDelay = 1
    
    func getCities(countryCode: String, completion: @escaping ([City]?) -> Void) {
        getCities(countryCode: countryCode, offset: citiesAccepted, completion: completion)
    }
    
    func getCities(countryCode: String, offset: Int?, completion: @escaping ([City]?) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        
        let urlParam = url.appending(queryItems: [
            URLQueryItem(name: "includeDeleted", value: "NONE"),
            URLQueryItem(name: "languageCode", value: lang),
            URLQueryItem(name: "countryIds", value: countryCode),
            URLQueryItem(name: "limit", value: "\(maxCitiesInResult)"),
            URLQueryItem(name: "offset", value: "\(offset ?? 0)")
        ])
        
        var request = URLRequest(url: urlParam, timeoutInterval: 20)
        request.addValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
        
        let dataTask = URLSession.shared.dataTask(with: request,completionHandler: { [weak self] data, response, error in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let citiesArrayData = json["data"],
                  let data = try? JSONSerialization.data(withJSONObject: citiesArrayData),
                  let cities = try? JSONDecoder().decode([City].self, from: data) else {
                completion(nil)
                return
            }
            self?.citiesAccepted += cities.count
            completion(cities)
        })
        dataTask.resume()
        
    }
}
