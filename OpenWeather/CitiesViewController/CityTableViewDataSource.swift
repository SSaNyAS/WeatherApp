//
//  CityTableViewDataSource.swift
//  OpenWeather
//
//  Created by Алексей Рябин on 21.07.2022.
//

import Foundation
import UIKit

public class CityTableViewDataSource : NSObject, UITableViewDataSource{
    var cities: [City]
    
    init(with cities: [City]){
        self.cities = cities
        super.init()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseIdentifireType, for: indexPath)
        if let cellCity = cell as? CityTableViewCell{
            cellCity.isLastCell = indexPath.row == cities.count - 1
        }
        
        let currentCity = cities[indexPath.row]
        cell.textLabel?.text = currentCity.name
        cell.detailTextLabel?.text = currentCity.region
        return cell
    }
    
    
}
