//
//  WeatherVCPresenter.swift
//  OpenWeather
//
//  Created by Алексей Рябин on 25.08.2022.
//

import Foundation

protocol WeatherVCPresenterDelegate: PresenterDelegate{
    var viewDelegate: WeatherViewControllerDelegate? { get set }
    var weatherVCInteractor: WeatherVCInteractorProtocol { get set }
    func getWeather(for cityName: String)
}

class WeatherVCPresenter: WeatherVCPresenterDelegate{
    var weatherVCInteractor: WeatherVCInteractorProtocol
    weak var viewDelegate: WeatherViewControllerDelegate?
    var router: RouterDelegate?
    var cityName: String?
    
    init(weatherVCInteractor: WeatherVCInteractorProtocol){
        self.weatherVCInteractor = weatherVCInteractor
    }
    
    func getWeather(for cityName: String) {
        weatherVCInteractor.getWeather(for: cityName) { [weak viewDelegate] weather in
            guard let viewDelegate = viewDelegate else {
                return
            }

            if let weather = weather {
                if let temp = Int(weather.temp.description){
                    viewDelegate.setCityTemp(temp: temp)
                }
                viewDelegate.setCityName(name: weather.location.name)
            }
        }
    }
}
