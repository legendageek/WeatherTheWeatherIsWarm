//
//  SortedWeatherModel.swift
//  WeatherTheWeatherIsWarm
//
//  Created by Kirill Fukalov on 28.03.23.
//

import Foundation

//MARK: - SortedWeatherModel

struct SortedWeatherModel {
    let list: [SortedListModel]
    let city: SortedCityModel
}

// MARK: - SortedListModel

struct SortedListModel {
    let main: SortedMainModel
    let weather: [SortedWeatherElement]
    let visibility: Int
    let dtTxt: Date
}

// MARK: - SortedCityModel

struct SortedCityModel {
    let name: String
    let sunrise, sunset: Int
}

// MARK: - SortedWeatherElement

struct SortedWeatherElement {
    let weatherDescription, icon: String
}

// MARK: - SortedMainModel

struct SortedMainModel {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel: Int
}
