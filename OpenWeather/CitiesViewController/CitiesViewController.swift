//
//  ViewController.swift
//  OpenWeather
//
//  Created by Алексей Рябин on 21.07.2022.
//

import UIKit
protocol CitiesVCDelegate: AnyObject{
    func loadCities()
    func setData(tableViewDataSource: UITableViewDataSource)
    var itemsCount: Int {get set}
}

class CitiesViewController: UIViewController, CitiesVCDelegate{
    
    weak var tableView: UITableView?
    var refreshControl: UIRefreshControl?
    
    var presenter: CitiesVCPresenterDelegate?
    private var citiesDataSource: UITableViewDataSource?
    var itemsCount: Int = 0
    private var lastRefreshTime: Date = Date(timeIntervalSince1970: 0)
    private let refreshRateSeconds: TimeInterval = 1
    required init(presenter: CitiesVCPresenterDelegate) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(loadCities), for: .valueChanged)
        
        setupTableView()
        loadCities()
    }
    
    func setData(tableViewDataSource: UITableViewDataSource) {
        DispatchQueue.main.async { [weak self] in
            self?.lastRefreshTime = Date()
            self?.citiesDataSource = tableViewDataSource
            self?.tableView?.dataSource = self?.citiesDataSource
            self?.updateTableView()
        }
    }
    
    @objc func loadCities() {
        if Date() > lastRefreshTime.addingTimeInterval(refreshRateSeconds){
            startLoadingAnimation()
            presenter?.getCities()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now()+refreshRateSeconds){ [weak self] in
                self?.startLoadingAnimation()
                self?.presenter?.getCities()
            }
        }
    }
    
    private func startLoadingAnimation(){
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl?.beginRefreshing()
        }
    }
    
    private func updateTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView?.reloadData()
            //self?.tableView?.insertRows(at: , with: .automatic)
            self?.refreshControl?.endRefreshing()
        }
    }
    
    func setupTableView(){
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.refreshControl = self.refreshControl
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.reuseIdentifireType)
        tableView.delegate = self
        self.tableView = tableView
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension CitiesViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == itemsCount - 1 {
            loadCities()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(rowIndex: indexPath.row)
    }
}
