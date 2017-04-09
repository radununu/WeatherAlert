//
//  DateHelper.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/20/16.
//
//

import UIKit

enum WeekDays: Int {
    case sunday, monday, tuesday, wednesday, thursday, friday, saturday
}

class DateHelper {
    func dayIndexFromStringDate(_ date: String) -> Int {
        return dateComponents(dateValueFromString(date)).weekday!
    }
    
    func dayStringByDate(_ date: Date) -> String {
        let weekDayIndex = dateComponents(date).weekday
        guard let day = WeekDays(rawValue: weekDayIndex! - 1) else { return String() }
        return String(describing: day)
    }
    
    func dateValueFromString(_ date: String) -> Date {
        return dateFormatter.date(from: date) ?? Date()
    }
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter
    }()
    
    func dateComponents(_ date: Date) -> DateComponents {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return (calendar as NSCalendar?)?.components(.weekday, from: date) ?? DateComponents()
    }
}
