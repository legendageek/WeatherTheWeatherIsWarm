//
//  StyleSheet.swift
//  WeatherTheWeatherIsWarm
//
//  Created by Kirill Fukalov on 28.03.23.
//

import UIKit

struct StyleSheet {
    
    //MARK: - WeatherView
    
    func addCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionLayout.createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.cornerRadius = 15
        collectionView.backgroundColor = .clear.withAlphaComponent(0.15)
        return collectionView
    }
    
    func addTableView() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 15
        tableView.isScrollEnabled = false
        tableView.rowHeight = 70
        tableView.backgroundColor = .clear
//        tableView.
        return tableView
    }
    
    func addScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }
    
    func addCityLabel() -> UILabel {
        let cityLabel = UILabel()
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = UIFont.boldSystemFont(ofSize: 30)
        cityLabel.textColor = .systemBackground
        cityLabel.textAlignment = .center
        return cityLabel
    }
    
    func addViewWeek() -> UIView {
        let weekView = UIView()
        weekView.translatesAutoresizingMaskIntoConstraints = false
        weekView.backgroundColor = .clear
        weekView.layer.cornerRadius = 15
        return weekView
    }
    
    func addWeatherDescription() -> UILabel {
        let weatherDescription = UILabel()
        weatherDescription.translatesAutoresizingMaskIntoConstraints = false
        weatherDescription.font = UIFont.boldSystemFont(ofSize: 14)
        weatherDescription.textColor = .systemBackground
        weatherDescription.textAlignment = .center
        return weatherDescription
    }
    
    func addDegrees() -> UILabel {
        let degrees = UILabel()
        degrees.translatesAutoresizingMaskIntoConstraints = false
        degrees.font = UIFont.boldSystemFont(ofSize: 100)
        degrees.textColor = .systemBackground
        degrees.textAlignment = .center
        degrees.numberOfLines = 0
        return degrees
    }
    
    func addDay() -> UILabel {
        let day = UILabel()
        day.translatesAutoresizingMaskIntoConstraints = false
        day.font = UIFont.boldSystemFont(ofSize: 15)
        day.textColor = .systemBackground
        day.textAlignment = .center
        return day
    }
    
    func addMaxMinDegrees() -> UILabel {
        let maxMinDegrees = UILabel()
        maxMinDegrees.translatesAutoresizingMaskIntoConstraints = false
        maxMinDegrees.font = UIFont.boldSystemFont(ofSize: 15)
        maxMinDegrees.textColor = .systemBackground
        maxMinDegrees.textAlignment = .center
        return maxMinDegrees
    }
}
