//
//  MainViewController.swift
//  NextsenseTask
//
//  Created by Aleksandar Micevski on 23.7.22.
//

import UIKit
import SnapKit
import Kingfisher
import CoreLocation

class MainViewController: UIViewController {
    
    var searchController: UISearchController!
    var currentWeatherView: CurrentWeatherView!
    var forecastTableView: UITableView!
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var forecastResponse: ForecastResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        setupConstraints()
        setupLocationManager()
    }
    
    func setupViews() {
        self.view.backgroundColor = .white
        
        searchController = UISearchController()
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        
        currentWeatherView = CurrentWeatherView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width / 2))
        self.view.addSubview(currentWeatherView)
        
        forecastTableView = UITableView()
        forecastTableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: "cell")
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
        self.view.addSubview(forecastTableView)
    }
    
    func setupConstraints() {
        currentWeatherView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.right.equalTo(self.view)
            make.height.equalTo(self.view.frame.size.width / 2)
        }
        
        forecastTableView.snp.makeConstraints { make in
            make.top.equalTo(currentWeatherView.snp.bottom)
            make.left.right.bottom.equalTo(self.view)
        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

//MARK: - LOCATION MANAGER DELEGATES
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty && currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            getCurrentWeather(location: currentLocation)
            getForecast(location: currentLocation)
        }
    }
}

//MARK: - SEARCH CONTROLLER DELEGATES
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        let replacedString = (searchText as NSString).replacingOccurrences(of: " ", with: "+")
        getWeatherData(city: replacedString)
    }
}

//MARK: - FORECAST TABLEVIEW DELEGATES
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let forecastResponse = forecastResponse else { return 0 }
        return forecastResponse.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = forecastTableView.dequeueReusableCell(withIdentifier: "cell") as! ForecastTableViewCell
        cell.configure(forecast: forecastResponse?.list[indexPath.row])
        return cell
    }
}

//MARK: - API COMMUNICATION
extension MainViewController {
    
    func getCurrentWeather(location: CLLocation?) {
        guard let location = location else { return }

        ApiManager.shared.getCurrentWeather(location: location) { result in
            switch result {
            case .success(let data):
                var json: CurrentWeatherResponse?
                do {
                    json = try JSONDecoder().decode(CurrentWeatherResponse.self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
                
                guard let weatherResponse = json else { return }
                DispatchQueue.main.async {
                    self.currentWeatherView.configure(weather: weatherResponse)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getWeatherData(city: String) {
        ApiManager.shared.getCityLocation(city: city) { result in
            switch result {
            case .success(let data):
                var json: CityResponse?
                do {
                    json = try JSONDecoder().decode(CityResponse.self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
                
                guard let cityResponse = json else { return }
                let location = CLLocation(latitude: cityResponse.city.lat, longitude: cityResponse.city.lon)
                self.getForecast(location: location)
                self.getCurrentWeather(location: location)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getForecast(location: CLLocation?) {
        guard let location = location else { return }

        ApiManager.shared.getForecast(location: location) { result in
            switch result {
            case .success(let data):
                var json: ForecastResponse?
                do {
                    json = try JSONDecoder().decode(ForecastResponse.self, from: data)
                } catch {
                    print (error.localizedDescription)
                }
                
                guard let forecastResponse = json else { return }
                
                self.forecastResponse = forecastResponse
                DispatchQueue.main.async {
                    self.forecastTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
