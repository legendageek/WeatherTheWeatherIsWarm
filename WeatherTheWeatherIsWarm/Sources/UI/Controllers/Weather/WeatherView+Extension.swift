//
//  WeatherView+Extension.swift
//  WeatherTheWeatherIsWarm
//
//  Created by Kirill Fukalov on 28.03.23.
//

import UIKit

// MARK: - UITableViewDelegate, UITableViewDataSource

extension WeatherView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherModel?.sortedWeatherModel.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Прогноз на 5 дней"
        label.textColor = .white
        label.layer.backgroundColor = .init(gray: 0.0, alpha: 1.0)
        label.alpha = 0.7
        label.textAlignment = .center
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cellid") as? TableViewCell else { return UITableViewCell() }
        
        guard let allTimeModel = weatherModel?.sortedWeatherModel.list.map({$0.dtTxt}) else {return UITableViewCell()}
        let allTime = allTimeModel[indexPath.row]
        cell.weekDayLabel.text = dateFormater(datef: allTime)
        
        guard let nameImage = weatherModel?.sortedWeatherModel.list.map({$0.weather}).compactMap({$0.last?.icon}) else {return UITableViewCell()}
        let nameString = nameImage[indexPath.row]
        cell.weatherConditionIcon.image = setImage(name: nameString)
        
        guard let allMinDegrees = weatherModel?.sortedWeatherModel.list.map({$0.main.tempMin}) else {return UITableViewCell()}
        let allMinDegreesInt = doubleToInteger(data: allMinDegrees)
        cell.minTemperature.text = "\(allMinDegreesInt[indexPath.row])°"
        
        guard let allMaxDegrees = weatherModel?.sortedWeatherModel.list.map({$0.main.tempMax}) else {return UITableViewCell()}
        let allMaxDegreesInt = doubleToInteger(data: allMaxDegrees)
        cell.maxTemperature.text = "\(allMaxDegreesInt[indexPath.row])°"
        cell.backgroundColor = .clear.withAlphaComponent(0.15)
        cell.selectionStyle = .none
        cell.prepareForReuse()
        return cell
    }
    
    func doubleToInteger(data: [Double]) -> [Int] {
        let doubleToString = data
        var arrInt: [Int] = []
        for i in doubleToString {
           let int = doubleToInteger(data: i)
            arrInt.append(int)
        }
        return arrInt
    }
    
    func dateFormater(datef: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let allTimeStr = dateFormatter.string(from: datef).capitalized
        return allTimeStr
    }
    
    func setImage(name: String) -> UIImage {
        let name = name
        var image = UIImage()
        image = UIImage(named: name) ?? UIImage(systemName: "scribble")!
        return image
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension WeatherView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  weatherModel?.weatherModel.list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? CustomCollectionCell else { return UICollectionViewCell() }
        
        let model = weatherModel?.weatherModel.list[indexPath.item]
        cell.configure(listModel: model)
        
        return cell
    }
    
}
