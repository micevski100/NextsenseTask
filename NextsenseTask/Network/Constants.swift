//
//  Constants.swift
//  NextsenseTask
//
//  Created by Aleksandar Micevski on 23.7.22.
//

import Foundation

struct Constants {
    static let baseURL = "https://api.openweathermap.org"
    static let API_KEY = "289bb1628a4cdb62b113b6ef961ee74c"
    
    struct Endpoints {
        static let currentWeather = "/weather"
        static let forecast = "/forecast"
        static let direct = "/direct"
    }
}
