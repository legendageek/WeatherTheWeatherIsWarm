//
//  DatesFormater.swift
//  WeatherTheWeatherIsWarm
//
//  Created by Kirill Fukalov on 28.03.23.
//

import Foundation

class DatesFormatter {
    
    //MARK: -Internal methods
    
    static func dateFormater(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let allTimeStr = dateFormatter.string(from: date)
        return allTimeStr
    }
    
    static func compare(date: Date, equalTo: Date, dateComponents: Set<Calendar.Component>) -> Bool {
        dateFromComponents(dateComponents: dateComponents, date: date) == dateFromComponents(dateComponents: dateComponents, date: equalTo)
    }
    
    static func dateFromComponents(dateComponents: Set<Calendar.Component>, date: Date) -> Date {
        let components = Calendar.current.dateComponents(dateComponents, from: date)
        return Calendar.current.date(from: components) ?? .now
    }
}
