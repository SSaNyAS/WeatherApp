//
//  City.swift
//  OpenWeather
//
//  Created by Алексей Рябин on 21.07.2022.
//

import Foundation

struct City: Codable, Equatable{
    let id: UInt32
    let name: String
    let region: String
    let regionCode: String
    
    private enum CodingKeys: String, CodingKey{
        case id
        case name = "city"
        case region
        case regionCode
    }
}
