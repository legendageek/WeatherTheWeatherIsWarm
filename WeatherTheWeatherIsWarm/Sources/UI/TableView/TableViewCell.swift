//
//  TableViewCell.swift
//  WeatherTheWeatherIsWarm
//
//  Created by Kirill Fukalov on 28.03.23.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //MARK: - Let
    
    let weekDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let weatherConditionIcon: UIImageView = {
        let weatherConditionIcon = UIImageView()
        weatherConditionIcon.translatesAutoresizingMaskIntoConstraints = false
        return weatherConditionIcon
    }()
    
    let minTemperature: UILabel = {
        let minTemperature = UILabel()
        minTemperature.translatesAutoresizingMaskIntoConstraints = false
        minTemperature.textAlignment = .center
        minTemperature.textColor = .white
        return minTemperature
    }()
    
    let maxTemperature: UILabel = {
        let maxTemperature = UILabel()
        maxTemperature.translatesAutoresizingMaskIntoConstraints = false
        maxTemperature.textAlignment = .center
        maxTemperature.textColor = .white
        return maxTemperature
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Setup constraints
    
    func addLabels() {
        addSubview(weekDayLabel)
        NSLayoutConstraint.activate([
            weekDayLabel.topAnchor.constraint(equalTo: topAnchor),
            weekDayLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 5),
            weekDayLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            weekDayLabel.heightAnchor.constraint(equalTo: heightAnchor),
            weekDayLabel.widthAnchor.constraint(equalToConstant: 170)
        ])
        
        addSubview(weatherConditionIcon)
        NSLayoutConstraint.activate([
            weatherConditionIcon.topAnchor.constraint(equalTo: topAnchor),
            weatherConditionIcon.leadingAnchor.constraint(equalTo: weekDayLabel.trailingAnchor),
            weatherConditionIcon.bottomAnchor.constraint(equalTo: bottomAnchor),
            weatherConditionIcon.heightAnchor.constraint(equalTo: heightAnchor),
            weatherConditionIcon.widthAnchor.constraint(equalToConstant: 75)
        ])
        
        addSubview(minTemperature)
        NSLayoutConstraint.activate([
            minTemperature.topAnchor.constraint(equalTo: topAnchor),
            minTemperature.leadingAnchor.constraint(equalTo: weatherConditionIcon.trailingAnchor),
            minTemperature.bottomAnchor.constraint(equalTo: bottomAnchor),
            minTemperature.heightAnchor.constraint(equalTo: heightAnchor),
            minTemperature.widthAnchor.constraint(equalToConstant: 75)
        ])
        
        addSubview(maxTemperature)
        NSLayoutConstraint.activate([
            maxTemperature.topAnchor.constraint(equalTo: topAnchor),
            maxTemperature.leadingAnchor.constraint(equalTo: minTemperature.trailingAnchor),
            maxTemperature.trailingAnchor.constraint(equalTo: trailingAnchor),
            maxTemperature.heightAnchor.constraint(equalTo: heightAnchor),
            maxTemperature.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
//MARK: - Configure
    
//    func configure(listModel: ListModel?) {
//        if let degree = listModel?.main.temp {
//            degrees.text = Int(degree).description + "°"
//        }
//        if let date = listModel?.dtTxt {
//            time.text = DatesFormatter.dateFormater(date: date, format: "HH")
//        }
//        if let imageName = listModel?.weather.last?.icon {
//            weatherImage.image = UIImage(named: imageName)
//        }
        
    func configure(sortedListModel: SortedListModel?) {
        
        if let allTime = sortedListModel?.dtTxt {
            weekDayLabel.text = DatesFormatter.dateFormater(date: allTime, format: "EEEE dd")
        }
        
        if let nameImage = sortedListModel?.weather.last?.icon {
            weatherConditionIcon.image = UIImage(named: nameImage)
        }
        
        if let minDegrees = sortedListModel?.main.tempMin {
            minTemperature.text = "\(minDegrees)°"
        }
        
        if let maxDegrees = sortedListModel?.main.tempMin{
            maxTemperature.text = "\(maxDegrees)°"
        }
    }
}
