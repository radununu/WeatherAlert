//
//  DateHelper.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/20/16.
//
//

import UIKit


class DateHelper {
    func dayStringByDate(date: NSDate) -> String {
        return DaysOfWeek(rawValue: dateComponents(date).day)!.stringValue()
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
        let components: NSDateComponents = calendar!.components(.Weekday, fromDate: date)
        return components
    }
}
