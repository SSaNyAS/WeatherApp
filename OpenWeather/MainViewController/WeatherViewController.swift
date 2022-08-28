//
//  MainViewController.swift
//  OpenWeather
//
//  Created by Алексей Рябин on 23.07.2022.
//
import UIKit

protocol WeatherViewControllerDelegate: UIViewController{
    func getWeather()
    func setCityName(name: String)
    func setCityTemp(temp: Int)
}
class WeatherViewController: UIViewController, WeatherViewControllerDelegate {
    
    weak var titleLabel: UILabel?
    weak var tempLabel: UILabel?
    
    var weatherPresenter: WeatherVCPresenterDelegate?
    
    init(weatherPresenter: WeatherVCPresenterDelegate){
        self.weatherPresenter = weatherPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.weatherPresenter = nil
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        setupTitleLabel()
        setupTempLabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getWeather()
    }
    
    func getWeather() {
        weatherPresenter?.getWeather(for: "Бугуруслан")
    }
    
    func setCityName(name: String) {
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel?.text = name
        }
    }
    
    func setCityTemp(temp: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.tempLabel?.text = "\(temp)˚C"
        }
    }
    
    private func setupTempLabel(){
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 56, weight: .medium)
        label.textColor = .black
        
        view.addSubview(label)
        self.tempLabel = label
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 40),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            label.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupTitleLabel(){
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 36, weight: .bold)
        label.textColor = .orange
        
        view.addSubview(label)
        self.titleLabel = label
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 60),
            label.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -60)
        ])
    }
}
