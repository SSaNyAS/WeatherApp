//
//  CitiesVCPresenter.swift
//  OpenWeather
//
//  Created by Алексей Рябин on 26.08.2022.
//

import Foundation
import UIKit

protocol CitiesVCPresenterDelegate: AnyObject,PresenterDelegate{
    var viewDelegate: CitiesVCDelegate? {get set}
    var citiesVCInteractor: CitiesVCInteractorDelegate? {get set}
    func getCities()
    func didSelectRow(rowIndex: Int)
}

class CitiesVCPresenter: CitiesVCPresenterDelegate{
    func didSelectRow(rowIndex: Int) {
        if let viewController = viewDelegate as? UIViewController{
            router?.goToViewController(from: viewController, to: .WeatherVC, presentationMode: .modal)
        }
    }
    
    var router: RouterDelegate?
    weak var viewDelegate: CitiesVCDelegate?
    var citiesVCInteractor: CitiesVCInteractorDelegate?
    
    init(interactor: CitiesVCInteractor){
        self.citiesVCInteractor = interactor
    }
    
    func getCities() {
        citiesVCInteractor?.getCities(completion: { [weak self] cities in
            if let cities = cities {
                let citiesDataSource = CityTableViewDataSource(with: cities)
                self?.viewDelegate?.setData(tableViewDataSource: citiesDataSource)
                self?.viewDelegate?.itemsCount = cities.count
            }
        })
    }
}
