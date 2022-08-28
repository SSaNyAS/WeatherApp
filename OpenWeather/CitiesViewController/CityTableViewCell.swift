//
//  CityTableViewCell.swift
//  OpenWeather
//
//  Created by Алексей Рябин on 26.08.2022.
//

import Foundation
import UIKit

class CityTableViewCell: UITableViewCell{
    static var reuseIdentifireType: String = "CityCell"
    var isLastCell: Bool = false
    
    init(){
        super.init(style: .subtitle, reuseIdentifier: CityTableViewCell.reuseIdentifireType)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(style: .subtitle, reuseIdentifier: CityTableViewCell.reuseIdentifireType)
    }
}

