//
//  ForecastWind.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/19/16.
//
//

import Foundation

struct ForecastWindModel {
    let degrees: Double
    let speed: Float
    let date: String
    let dateHelper = DateHelper()
    var dateValue: Date { get { return dateHelper.dateValueFromString(self.date)} }
    fileprivate let speedUnit = "meter/sec"

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
        return dateHelper.dayStringByDate(dateValue)
    }
}
