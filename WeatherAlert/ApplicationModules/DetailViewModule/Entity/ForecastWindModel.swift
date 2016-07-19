//
//  ForecastWind.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/19/16.
//
//

import Foundation

enum DaysOfWeek: Int {
    case Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
    func stringValue() -> String {
        let daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        return daysOfWeek[self.rawValue]
    }
}

struct ForecastWindModel {
    let degrees: Double
    let speed: Float
    let date: String
    let dateHelper = DateHelper()
    var dateValue: NSDate { get { return dateHelper.dateValueFromString(self.date)} }
    private let speedUnit = "meter/sec"

    init(responseObject: [String: AnyObject]) {
        self.date = (responseObject["dt_txt"] as? String) ?? ""
        guard let windObject = responseObject["wind"] as? [String: AnyObject] else {
            speed = 0.0
            degrees = 0.0
            return
        }
        self.degrees = (windObject["deg"] as? Double) ?? 0.0
        self.speed = (windObject["speed"] as? Float) ?? 0.0
    }
    
    func formattedSpeed() -> String {
        return String(self.speed) + " " + speedUnit
    }
    
    func windDirection() -> String {
        return String().windDirectionFromDegrees(self.degrees)
    }
    
    func weekDay() -> String {
        let weekDay = dateHelper.dateComponents(dateValue).weekday
        return DaysOfWeek(rawValue: weekDay - 1)!.stringValue()
    }
}
