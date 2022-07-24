//
//  CurrentWeatherView.swift
//  NextsenseTask
//
//  Created by Aleksandar Micevski on 23.7.22.
//

import UIKit

enum WeatherTypes: String {
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case scatteredClouds = "scattered clouds"
    case brokenClouds = "broken clouds"
    case showerRain = "shower rain"
    case rain = "rain"
    case thunderstorm = "thunderstorm"
    case snow = "snow"
    case mist = "mist"
}

class CurrentWeatherView: UIView {
    
    var weatherImageView: UIImageView!
    var cityLabel: UILabel!
    var tempLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = .clear
        
        weatherImageView = UIImageView()
        self.addSubview(weatherImageView)
        
        cityLabel = UILabel()
        cityLabel.font = UIFont.systemFont(ofSize: 30)
        self.addSubview(cityLabel)
        
        tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 30)
        self.addSubview(tempLabel)
    }
    
    func setupConstraints() {
        weatherImageView.snp.makeConstraints { make in
            make.left.centerY.equalTo(self)
            make.width.height.equalTo(self.frame.size.width / 2)
        }
        
        cityLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(weatherImageView.snp.right).offset(20)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(20)
            make.centerX.equalTo(cityLabel.snp.centerX)
        }
    }
    
    func configure(weather: CurrentWeatherResponse) {
        cityLabel.text = weather.name
        tempLabel.text = "\(Int(weather.main.temp - 273.15))°C"
        
        let weather = weather.weather[0].description
        switch weather {
        case WeatherTypes.clearSky.rawValue:
            weatherImageView.image = UIImage(systemName: "sun.min")
        case WeatherTypes.fewClouds.rawValue:
            weatherImageView.image = UIImage(systemName: "cloud.fill")
        case WeatherTypes.scatteredClouds.rawValue:
            weatherImageView.image = UIImage(systemName: "cloud.fill")
        case WeatherTypes.brokenClouds.rawValue:
            weatherImageView.image = UIImage(systemName: "cloud.fill")
        case WeatherTypes.showerRain.rawValue:
            weatherImageView.image = UIImage(systemName: "cloud.rain.fill")
        case WeatherTypes.rain.rawValue:
            weatherImageView.image = UIImage(systemName: "cloud.rain.fill")
        case WeatherTypes.thunderstorm.rawValue:
            weatherImageView.image = UIImage(systemName: "cloud.bolt.rain.fill")
        case WeatherTypes.snow.rawValue:
            weatherImageView.image = UIImage(systemName: "cloud.snow")
        case WeatherTypes.mist.rawValue:
            weatherImageView.image = UIImage(systemName: "cloud.snow")
        default:
            weatherImageView.image = UIImage(named: "no_image_available")
        }   
    }
}
