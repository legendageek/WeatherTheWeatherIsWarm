//
//  WeatherView.swift
//  WeatherTheWeatherIsWarm
//
//  Created by Kirill Fukalov on 28.03.23.
//

import UIKit

final class WeatherView: UIView, UIScrollViewDelegate {
    
    // MARK: - Var
    
    var weatherModel: GlobalWeatherModel?
    
    var constraint = NSLayoutConstraint()
    
    var constraintHeight = NSLayoutConstraint()
    
    // MARK: - Let
    
    let gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.red.cgColor,
            UIColor.purple.cgColor,
            UIColor.cyan.cgColor
        ]
        gradient.locations = [0, 0.25, 1]
        return gradient
    }()
    
    let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        return loader
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = StyleSheet().addCollectionView()
        return collectionView
    }()
    
    let tableView: UITableView = {
        let tableView = StyleSheet().addTableView()
        return tableView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = StyleSheet().addScrollView()
        return scrollView
    }()
    
    let cityLabel: UILabel = {
        let cityLabel = StyleSheet().addCityLabel()
        return cityLabel
    }()
    
    let weatherViewWeek: UIView = {
        let weatherViewWeek = StyleSheet().addViewWeek()
        return weatherViewWeek
    }()
    
    let weatherDescription: UILabel = {
        let weatherDescription = StyleSheet().addWeatherDescription()
        return weatherDescription
    }()
    
    let degrees: UILabel = {
        let degrees = StyleSheet().addDegrees()
        return degrees
    }()
    
    let day: UILabel = {
        let day = StyleSheet().addDay()
        return day
    }()
    
    let dayOfWeek: String = {
        let dayOfWeek = String()
        return dayOfWeek
    }()
    
    let maxMinDegrees: UILabel = {
        let maxMinDegrees = StyleSheet().addMaxMinDegrees()
        return maxMinDegrees
    }()
    
    let cellId = "cellId"
    let tableCellId = "Cellid"
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
//        addBackground()
        addLoader()
        scrollView.delegate = self
        setupConstraints()
        setUpConstrainsScrollView()
        scrollViewDidScroll(scrollView)
        
        collectionView.register(CustomCollectionCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: tableCellId)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        loader.startAnimating()
    }
    
    // MARK: - Setup constraints

    func addLoader() {
        addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func setupConstraints() {
        addSubview(cityLabel)
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
        ])
        
        addSubview(weatherDescription)
        NSLayoutConstraint.activate([
            weatherDescription.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5),
            weatherDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            weatherDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100)
        ])
        
        addSubview(degrees)
        NSLayoutConstraint.activate([
            degrees.topAnchor.constraint(equalTo: weatherDescription.bottomAnchor, constant: 50),
            degrees.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            degrees.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
        ])
        
    }
    
    func setUpConstrainsScrollView() {
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: weatherDescription.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        scrollView.addSubview(weatherViewWeek)
        constraint = weatherViewWeek.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        NSLayoutConstraint.activate([
            weatherViewWeek.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 245),
            weatherViewWeek.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            weatherViewWeek.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            weatherViewWeek.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            constraint,
            weatherViewWeek.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        weatherViewWeek.addSubview(day)
        NSLayoutConstraint.activate([
            day.topAnchor.constraint(equalTo: weatherViewWeek.topAnchor),
            day.leadingAnchor.constraint(equalTo: weatherViewWeek.leadingAnchor, constant: 5)
        ])
        
        weatherViewWeek.addSubview(maxMinDegrees)
        NSLayoutConstraint.activate([
            maxMinDegrees.topAnchor.constraint(equalTo: weatherViewWeek.topAnchor),
            maxMinDegrees.trailingAnchor.constraint(equalTo: weatherViewWeek.trailingAnchor, constant: -5)
        ])
        
        weatherViewWeek.addSubview(collectionView)
        constraintHeight = collectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: day.bottomAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: weatherViewWeek.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: weatherViewWeek.trailingAnchor),
            constraintHeight
        ])
        
        weatherViewWeek.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: weatherViewWeek.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: weatherViewWeek.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: weatherViewWeek.bottomAnchor)
        ])
    }
    
    // MARK: - Scroll view did scroll
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
        }
        if (scrollView.contentOffset.y < 0){
            degrees.alpha = 0
            degrees.alpha = 1
        }
        if (scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height)){
            let percentage: CGFloat = (scrollView.contentOffset.y) / 160
            degrees.alpha = (percentage)
            degrees.alpha = (1 - percentage)
        }
    }
    
    // MARK: - Configure
    
    func configure(weatherModel: GlobalWeatherModel) {
        
        constraint.constant = CGFloat(weatherModel.sortedWeatherModel.list.count * 70 + 168)
        constraintHeight.constant = 120
        
        layoutIfNeeded()
        
        loader.stopAnimating()
        
        self.weatherModel = weatherModel
        tableView.reloadData()
        collectionView.reloadData()
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfTheWeekString = dateFormatter.string(from: date)
        day.text = dayOfTheWeekString.capitalized
        
        func isCurrentDay(date: Date) -> Bool {
            let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
            let dateComponentsToday = Calendar.current.dateComponents([.day, .month, .year], from: Date())
            return dateComponents.day == dateComponentsToday.day && dateComponents.month == dateComponentsToday.month &&
            dateComponents.year == dateComponentsToday.year
        }
        
        guard let maxDegrees = weatherModel.weatherModel.list.filter({Calendar.current.isDateInToday($0.dtTxt)}).map({ $0.main.tempMax }).max() else { return }
        guard let minDegrees = weatherModel.weatherModel.list.filter({ isCurrentDay(date: $0.dtTxt) }).map({ $0.main.tempMin }).min() else { return }
        maxMinDegrees.text = "\(doubleToInteger(data: maxDegrees))°  \(doubleToInteger(data: minDegrees))°"
        
        cityLabel.text = weatherModel.weatherModel.city.name
        
        guard let modelWeatherDescription = weatherModel.weatherModel.list.first?.weather.first?.weatherDescription else { return }
        
        weatherDescription.text = modelWeatherDescription.capitalized
        
        guard let modelDegrees = weatherModel.weatherModel.list.first?.main.temp else { return }
        degrees.text = "\(doubleToInteger(data: modelDegrees))°"
        
    }
    
    public func doubleToInteger(data: Double) -> Int {
        let doubleToString = "\(data)"
        let stringToInteger = (doubleToString as NSString).integerValue
        return stringToInteger
    }
    
}
