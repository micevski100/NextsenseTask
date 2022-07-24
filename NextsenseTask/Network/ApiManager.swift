//
//  ApiManager.swift
//  NextsenseTask
//
//  Created by Aleksandar Micevski on 23.7.22.
//

import Foundation
import CoreLocation

class ApiManager {
    static let shared = ApiManager()
    
    func getForecast(location: CLLocation, completion: @escaping (Result<Data, Error>) -> Void) {
        let query = "lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(Constants.API_KEY)"
        let urlString = "\(Constants.baseURL)/data/2.5\(Constants.Endpoints.forecast)?\(query)"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
//                completion(.failure(error))
                return
            }
            
            
            completion(.success(data))
        }.resume()
    }
    
    func getCityLocation(city: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let query = "\(city)&limit=1&appid=\(Constants.API_KEY)"
        let urlString = "\(Constants.baseURL)/geo/1.0\(Constants.Endpoints.direct)?q=\(query)"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(data!))
        }.resume()
    }
    
    func getCurrentWeather(location: CLLocation, completion: @escaping (Result<Data, Error>) -> Void) {
        let query = "lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(Constants.API_KEY)"
        let urlString = "\(Constants.baseURL)/data/2.5\(Constants.Endpoints.currentWeather)?\(query)"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(data!))
        }.resume()
    }
}
