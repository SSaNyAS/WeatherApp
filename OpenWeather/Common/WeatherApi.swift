//
//  WeatherApi.swift
//  OpenWeather
//
//  Created by Алексей Рябин on 22.07.2022.
//

import Foundation

protocol WeatherApiDelegate{
    var lang: String {get set}
    func getWeather(for cityName: String, completion: @escaping (Weather?) -> Void)
    func getForecast(for cityName: String, completion: @escaping (Weather?)->Void)
}

class WeatherApi : WeatherApiDelegate{
    let url: String = "https://api.weatherapi.com/v1/current.json"
    let apiKey = "5ab18f555d734916ba3203631222107"
    var lang: String
    
    init(){
        self.lang = Locale.current.languageCode ?? "en"
    }
    
    init(lang: String){
        self.lang = lang
    }
    
    func getWeather(for cityName: String, completion: @escaping (Weather?) -> Void){
        guard let url = URL(string: url) else {
            return
        }
        
        let urlParam = url.appending(queryItems: [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "lang", value: lang),
            URLQueryItem(name: "q", value: cityName)
        ])
        
        let request = URLRequest(url: urlParam, timeoutInterval: 20)
        
        URLSession.shared.dataTask(with: request,completionHandler: { data, response, error in
            guard let data = data, let weather = try? JSONDecoder().decode(Weather.self, from: data) else {
                completion(nil)
                return
            }
            completion(weather)
        }).resume()
    }
    
    func getForecast(for cityName: String, completion: @escaping (Weather?) -> Void) {
        completion(nil)
    }
    
}
