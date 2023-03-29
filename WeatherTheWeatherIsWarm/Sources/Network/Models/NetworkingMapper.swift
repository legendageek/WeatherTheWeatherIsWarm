//
//  NetworkingMapper.swift
//  WeatherTheWeatherIsWarm
//
//  Created by Kirill Fukalov on 28.03.23.
//

import Foundation

//MARK: - NetworkingMapper

struct NetworkingMapper {
    static func map(response: WeatherResponseModel) -> GlobalWeatherModel {
        GlobalWeatherModel(response: response)
    }
}

//MARK: - GlobalWeatherModel

extension GlobalWeatherModel {
    init(response: WeatherResponseModel) {
        self.init(weatherModel: WeatherModel(response: response),
                  sortedWeatherModel: SortedWeatherModel(response: response))
    }
}

//MARK: - SortedWeatherModel

extension SortedWeatherModel {
    init(response: WeatherResponseModel) {
//        let sortedList = response.list.sorted(by: {$0.main.tempMax > $1.main.tempMax}).reduce(into: [ListResponseModel]()) { collection, item in
        let sortedList = response.list.reduce(into: [ListResponseModel]()) { collection, item in
            guard !collection.contains(where: { DatesFormatter.compare(date: item.dtTxt, equalTo: $0.dtTxt, dateComponents: [.day, .month]) }) else { return }
            collection.append(item)
        }
        self.init(list: sortedList.map { SortedListModel(response: $0) },
                  city: SortedCityModel(response: response.city))
    }
}

extension SortedListModel {
    init(response: ListResponseModel) {
        self.init(main: SortedMainModel(response: response.main),
                  weather: response.weather.map {
            SortedWeatherElement(
                weatherDescription: $0.weatherDescription,
                icon: $0.icon)} ,
                  visibility: response.visibility,
                  dtTxt: response.dtTxt)
    }
}
//static func sortedModel(response: ListResponseModel) -> SortedModel

extension SortedCityModel {
    init(response: CityResponseModel) {
        self.init(name: response.name,
                  sunrise: response.sunrise,
                  sunset: response.sunset)
    }
}

extension SortedMainModel {
    init(response: MainResponseModel) {
        self.init(temp: response.temp,
                  feelsLike: response.feelsLike,
                  tempMin: response.tempMin,
                  tempMax: response.tempMax,
                  pressure: response.pressure,
                  seaLevel: response.seaLevel,
                  grndLevel: response.grndLevel)
    }
}

extension SortedWeatherElement {
    init(response: WeatherElementResponseModel) {
        self.init(weatherDescription: response.weatherDescription,
                  icon: response.icon)
    }
}

//MARK: - WeatherModel

extension WeatherModel {

    init(response: WeatherResponseModel) {
        let sortedList = response.list.reduce(into: [ListResponseModel]()) { collection, item in
            guard !collection.contains(where: { DatesFormatter.compare(date: item.dtTxt, equalTo: $0.dtTxt, dateComponents: [.hour]) }) else { return }
            collection.append(item)
            print (item)
        }
        self.init(list: sortedList.map { ListModel(response: $0) },
                  city: CityModel(response: response.city))
    }
}

extension ListModel {
    
    init(response: ListResponseModel) {
        self.init(main: MainModel(response: response.main),
                  weather: response.weather.map { WeatherElementModel(response: $0)} ,
                  visibility: response.visibility,
                  dtTxt: response.dtTxt)
    }
}

extension CityModel {
    init(response: CityResponseModel) {
        self.init(name: response.name,
                  sunrise: response.sunrise,
                  sunset: response.sunset)
    }
}

extension MainModel {
    init(response: MainResponseModel) {
        self.init(temp: response.temp,
                  feelsLike: response.feelsLike,
                  tempMin: response.tempMin,
                  tempMax: response.tempMax,
                  pressure: response.pressure,
                  seaLevel: response.seaLevel,
                  grndLevel: response.grndLevel)
    }
}

extension WeatherElementModel {
    init(response: WeatherElementResponseModel) {
        self.init(weatherDescription: response.weatherDescription,
                  icon: response.icon)
    }
}
