//
//  ForecastResponse.swift
//  NextsenseTask
//
//  Created by Aleksandar Micevski on 23.7.22.
//

import Foundation

struct ForecastResponse: Codable {
    var cod: String
    var message: Int
    var cnt: Int
    var list: [Forecast]
    var city: ForecastCity
}

struct Forecast: Codable {
    var dt: Int
    var main: ForecastMain
    var weather: [ForecastWeather]
    var clouds: ForecastClouds
    var wind: ForecastWind
    var visibility: Int
    var pop: Double
    var sys: ForecastSys
    var dt_txt: String
}

struct ForecastMain: Codable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Int
    var sea_level: Int
    var grnd_level: Int
    var humidity: Int
    var temp_kf: Double
}

struct ForecastWeather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct ForecastClouds: Codable {
    var all: Int
}

struct ForecastWind: Codable {
    var speed: Double
    var deg: Int
    var gust: Double
}

struct ForecastSys: Codable {
    var pod: String
}

struct ForecastCity: Codable {
    var id: Int
    var name: String
    var coord: ForecastCityCoord
    var country: String
    var population: Int
    var timezone: Int
    var sunrise: Int
    var sunset: Int
}

struct ForecastCityCoord: Codable {
    var lat: Double
    var lon: Double
}
