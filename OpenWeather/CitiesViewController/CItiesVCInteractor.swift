//
//  CItyVCIterator.swift
//  OpenWeather
//
//  Created by Алексей Рябин on 26.08.2022.
//

import Foundation
protocol CitiesVCInteractorDelegate{
    var citiesVCPresenter: CitiesVCPresenterDelegate? {get set}
    var citiesApi: CitiesApiDelegate? {get set}
    func getCities(completion: @escaping ([City]?) -> Void)
}

class CitiesVCInteractor: CitiesVCInteractorDelegate{
    weak var citiesVCPresenter: CitiesVCPresenterDelegate?
    var citiesApi: CitiesApiDelegate?
    var cities: [City] = []
    
    init(citiesApi: CitiesApiDelegate){
        self.citiesApi = citiesApi
    }
    
    func getCities(completion: @escaping ([City]?) -> Void) {
        let locale = Locale.current.languageCode
        citiesApi?.getCities(countryCode: locale ?? "en", completion: {[weak self] citiesFromAPI in
            self?.cities.append(contentsOf: citiesFromAPI ?? [])
            completion(self?.cities ?? [])
        })
    }
}
