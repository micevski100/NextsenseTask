//
//  ForecastTableViewCell.swift
//  NextsenseTask
//
//  Created by Aleksandar Micevski on 23.7.22.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    var dateLabel: UILabel!
    var tempLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.contentView.backgroundColor = .clear
        
        dateLabel = UILabel()
        dateLabel.text = "Date"
        self.contentView.addSubview(dateLabel)
        
        tempLabel = UILabel()
        tempLabel.text = "Temp"
        self.contentView.addSubview(tempLabel)
    }
    
    func setupConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(20)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-20)
        }
    }
    
    func configure(forecast: Forecast?) {
        guard let forecast = forecast else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from:forecast.dt_txt)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        self.dateLabel.text = "\(components.month!)-\(components.day!) \(components.hour!)h"
        self.tempLabel.text = "\(Int(forecast.main.temp - 273.15))°C"
    }
}
