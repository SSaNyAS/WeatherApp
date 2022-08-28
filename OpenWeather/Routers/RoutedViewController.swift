//
//  ViewControllersEnum.swift
//  OpenWeather
//
//  Created by Алексей Рябин on 25.08.2022.
//
import UIKit
import Foundation
enum RoutedViewController{
    case WeatherVC
    case CitiesVC
    
    public var getViewController: UIViewController{
        switch self {
        case .WeatherVC:
            let weatherApi = WeatherApi()
            let weatherIterator = WeatherVCInteractor(weatherApi: weatherApi)
            
            let weatherPresenter = WeatherVCPresenter(weatherVCInteractor: weatherIterator)
            weatherPresenter.router = (UIApplication.shared.delegate as? AppDelegate)?.router
            
            let weatherViewController = WeatherViewController(weatherPresenter: weatherPresenter)
            weatherPresenter.viewDelegate = weatherViewController
            
            return weatherViewController
        case .CitiesVC:
            let citiesApi = CitiesApi()
            let iterator = CitiesVCInteractor(citiesApi: citiesApi)
            
            let presenter = CitiesVCPresenter(interactor: iterator)
            presenter.router = (UIApplication.shared.delegate as? AppDelegate)?.router
            
            let citiesViewController = CitiesViewController(presenter: presenter)
            presenter.viewDelegate = citiesViewController
            
            return citiesViewController
        }
    }
    
}
