//
//  MainVCIterator.swift
//  OpenWeather
//
//  Created by Алексей Рябин on 25.08.2022.
//

import Foundation
protocol WeatherVCInteractorProtocol{
    var weatherApi: WeatherApiDelegate {get}
    func getWeather(for cityName: String, completion: @escaping (Weather?)->Void)
}

class WeatherVCInteractor: WeatherVCInteractorProtocol{
    let weatherApi: WeatherApiDelegate
    
    init(weatherApi: WeatherApiDelegate){
        self.weatherApi = weatherApi
    }
    
    func getWeather(for cityName: String, completion: @escaping (Weather?) -> Void) {
        weatherApi.getWeather(for: cityName) { weather in
            completion(weather)
        }
    }
    
    
}
