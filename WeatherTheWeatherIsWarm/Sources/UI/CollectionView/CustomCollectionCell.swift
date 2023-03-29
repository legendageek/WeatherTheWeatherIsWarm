//
//  CustomCollectionCell.swift
//  WeatherTheWeatherIsWarm
//
//  Created by Kirill Fukalov on 28.03.23.
//

import UIKit

class CustomCollectionCell: UICollectionViewCell {
    
    //MARK: - Let
    
    let degrees: UILabel = {
        let degrees = StyleSheet().addDegrees()
        degrees.translatesAutoresizingMaskIntoConstraints = false
        degrees.font = UIFont.boldSystemFont(ofSize: 25)
        degrees.textColor = .white
        return degrees
    }()
    
    let time: UILabel = {
        let time = UILabel()
        time.translatesAutoresizingMaskIntoConstraints = false
        time.textAlignment = .center
        time.textColor = .white
        return time
    }()
    
    let weatherImage: UIImageView = {
        let weatherImage = UIImageView()
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        return weatherImage
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup constraints
    
    private func addLabels() {
        addSubview(time)
        NSLayoutConstraint.activate([
            time.topAnchor.constraint(equalTo: topAnchor),
            time.leadingAnchor.constraint(equalTo: leadingAnchor),
            time.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        addSubview(weatherImage)
        NSLayoutConstraint.activate([
            weatherImage.topAnchor.constraint(equalTo: time.bottomAnchor),
            weatherImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            weatherImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            weatherImage.heightAnchor.constraint(equalToConstant: 50)
        ])
        addSubview(degrees)
        NSLayoutConstraint.activate([
            degrees.topAnchor.constraint(equalTo: weatherImage.bottomAnchor),
            degrees.leadingAnchor.constraint(equalTo: leadingAnchor),
            degrees.trailingAnchor.constraint(equalTo: trailingAnchor),
            degrees.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    //MARK: - Configure
    
    func configure(listModel: ListModel?) {
        if let degree = listModel?.main.temp {
            degrees.text = Int(degree).description + "°"
        }
        if let date = listModel?.dtTxt {
            time.text = DatesFormatter.dateFormater(date: date, format: "HH")
        }
        if let imageName = listModel?.weather.last?.icon {
            weatherImage.image = UIImage(named: imageName)
        }
       
    }
}
