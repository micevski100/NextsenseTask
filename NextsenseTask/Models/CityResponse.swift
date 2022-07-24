//
//  CityResponse.swift
//  NextsenseTask
//
//  Created by Aleksandar Micevski on 23.7.22.
//

import Foundation

struct CityResponse: Codable {
    let city: City
    
    struct City: Codable {
        var name: String
        var lat: Double
        var lon: Double
    }
    
    init(from decoder:Decoder) throws {
        var container = try decoder.unkeyedContainer()
        city = try container.decode(City.self)
    }
}
