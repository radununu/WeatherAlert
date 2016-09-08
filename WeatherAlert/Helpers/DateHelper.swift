//
//  DateHelper.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/20/16.
//
//

import UIKit

enum WeekDays: Int {
    case Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
}

class DateHelper {
    func dayIndexFromStringDate(date: String) -> Int {
        return dateComponents(dateValueFromString(date)).weekday
    }
    
    func dayStringByDate(date: NSDate) -> String {
        let weekDayIndex = dateComponents(date).weekday
        guard let day = WeekDays(rawValue: weekDayIndex - 1) else { return String() }
        return String(day)
    }
    
    func dateValueFromString(date: String) -> NSDate {
        return dateFormatter.dateFromString(date) ?? NSDate()
    }
    
    lazy var dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        return dateFormatter
    }()
    
    func dateComponents(date: NSDate) -> NSDateComponents {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        return calendar?.components(.Weekday, fromDate: date) ?? NSDateComponents()
    }
}
