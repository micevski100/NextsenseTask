//
//  CurrentWeatherResponse.swift
//  NextsenseTask
//
//  Created by Aleksandar Micevski on 23.7.22.
//

import Foundation

struct CurrentWeatherResponse: Codable {
    var coord: CurrentWeatherCoord
    var weather: [CurrentWeather]
    var base: String
    var main: CurrentWeatherMain
    var visibility: Int
    var wind: CurrentWeatherWind
    var clouds: CurrentWeatherClouds
    var dt: Int
    var sys: CurrentWeatherSys
    var timezone: Int
    var id: Int
    var name: String
    var cod: Int
}

struct CurrentWeatherCoord: Codable {
    var lon: Double
    var lat: Double
}

struct CurrentWeather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct CurrentWeatherMain: Codable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Int
    var humidity: Int
}

struct CurrentWeatherWind: Codable {
    var speed: Double
    var deg: Int
}

struct CurrentWeatherClouds: Codable {
    var all: Int
}

struct CurrentWeatherSys: Codable {
    var type: Int
    var id: Int
    var message: String?
    var country: String
    var sunrise: Int
    var sunset: Int
}
