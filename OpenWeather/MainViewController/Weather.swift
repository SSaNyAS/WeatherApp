//
//  Weather.swift
//  OpenWeather
//
//  Created by Алексей Рябин on 22.07.2022.
//

import Foundation

struct Weather: Codable{
    let temp: Decimal
    let conditionText: String
    let conditionIconAddress: String
    let location: Location
    var isDay: Bool
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.location = try container.decode(Location.self, forKey: .location)
        
        let weatherContainer = try container.nestedContainer(keyedBy: CodingKeys.WeatherKeys.self, forKey: .weather)
        self.temp = try weatherContainer.decode(Decimal.self, forKey: .temp)
        let isTempNum = try weatherContainer.decode(Int.self, forKey: .isDay)
        self.isDay = isTempNum == 1
        
        let conditionContainer = try weatherContainer.nestedContainer(keyedBy: CodingKeys.WeatherKeys.ConditionKeys.self, forKey: .condition)
        self.conditionText = try conditionContainer.decode(String.self, forKey: .conditionText)
        self.conditionIconAddress = try conditionContainer.decode(String.self, forKey: .conditionIcon)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(location, forKey: .location)
        
        var weatherContainer = container.nestedContainer(keyedBy: CodingKeys.WeatherKeys.self, forKey: .weather)
        try weatherContainer.encode(temp, forKey: .temp)
        try weatherContainer.encode(isDay ? 1 : 0, forKey: .isDay)
        
        var conditionContainer = weatherContainer.nestedContainer(keyedBy: CodingKeys.WeatherKeys.ConditionKeys.self, forKey: .condition)
        try conditionContainer.encode(conditionText, forKey: .conditionText)
        try conditionContainer.encode(conditionIconAddress, forKey: .conditionText)
    }
    
    private enum CodingKeys: String, CodingKey{
        case weather = "current"
        case location = "location"
        enum WeatherKeys: String,CodingKey{
            case temp = "temp_c"
            case isDay = "is_day"
            case condition
            enum ConditionKeys: String, CodingKey{
                case conditionText = "text"
                case conditionIcon = "icon"
            }
        }
    }
}
