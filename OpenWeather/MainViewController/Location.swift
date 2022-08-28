//
//  Location.swift
//  OpenWeather
//
//  Created by Алексей Рябин on 22.07.2022.
//

import Foundation
import CoreLocation
struct Location: Codable{
    let name: String
    let region: String
    let country: String
    let coordinates: CLLocationCoordinate2D?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let name = try container.decode(String.self, forKey: .name)
        let region = try container.decode(String.self, forKey: .region)
        let country = try container.decode(String.self, forKey: .country)
        
        let latCoord = try? container.decode(Double.self, forKey: .coordinateLat)
        let lonCoord = try? container.decode(Double.self, forKey: .coordinateLon)
        
        self.name = name
        self.region = region
        self.country = country
        
        if let latCoord = latCoord, let lonCoord = lonCoord {
            let latCoord = CLLocationDegrees(latCoord)
            let lonCoord = CLLocationDegrees(lonCoord)
            self.coordinates = CLLocationCoordinate2D(latitude: latCoord, longitude: lonCoord)
        } else {
            self.coordinates = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(region, forKey: .region)
        try container.encode(country, forKey: .country)
        
        if let coordinates = coordinates {
            try? container.encode(coordinates.latitude, forKey: .coordinateLat)
            try? container.encode(coordinates.longitude, forKey: .coordinateLon)
        }
    }
    
    private enum CodingKeys: String, CodingKey{
        case name
        case region
        case country
        case coordinateLat = "lat"
        case coordinateLon = "lon"
    }
}
