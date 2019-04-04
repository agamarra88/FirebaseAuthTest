//
//  Date+Calendar.swift
//  Abstract
//
//  Created by Arturo Gamarra on 10/23/17.
//  Copyright © 2017 Abstract. All rights reserved.
//

import Foundation

extension Date {
    
    // MARK: - Private
    fileprivate func dateFormatter(withLocale locale:Locale) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        return formatter
    }
    
    fileprivate init?(fromComponents components:DateComponents) {
        let calendar = Calendar.current
        guard let date = calendar.date(from: components) else {
            return nil
        }
        self.init(timeInterval:0, since:date)
    }
    
    // MARK: - Public
    public var calendarComponents:DateComponents {
        let calendar = Calendar.current
        return calendar.dateComponents([.year, .month, .weekOfMonth, .weekday, .day], from: self)
    }
    
    public var firstDateOfMonth:Date {
        var components = self.calendarComponents
        components.day = 1
        return Date(fromComponents: components)!
    }
    
    public var lastDateOfMonth:Date {
        var components = self.calendarComponents
        components.month = components.month! + 1
        components.day = 0
        return Date(fromComponents: components)!
    }
    
    public var day:Int {
        return self.calendarComponents.day!
    }
    
    public var dayOrdinality:String {
        let ordinal = Date.ordinality(forDate: self)
        return "\(self.day)\(ordinal)"
    }
    
    public var weekDay:Int {
        return self.calendarComponents.weekday!
    }
    
    public var weekDayShortName:String {
        return weekDayShortName(forLocale: Locale.current)
    }
    
    public func weekDayShortName(forLocale locale: Locale) -> String {
        let formatter = dateFormatter(withLocale: locale)
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.weekday], from: self)
        return formatter.shortWeekdaySymbols[dateComponents.weekday! - 1]
    }
    
    public var weekDayName:String {
        return weekDayName(forLocale: Locale.current)
    }
    
    public func weekDayName(forLocale locale: Locale) -> String {
        let formatter = dateFormatter(withLocale: locale)
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.weekday], from: self)
        return formatter.weekdaySymbols[dateComponents.weekday! - 1]
    }
    
    public var month:Int {
        return self.calendarComponents.month!
    }
    
    public var monthShortName:String {
        return monthShortName(forLocale: Locale.current)
    }
    
    public func monthShortName(forLocale locale: Locale) -> String {
        let formatter = dateFormatter(withLocale: locale)
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.month], from: self)
        return formatter.shortMonthSymbols[dateComponents.month! - 1]
    }
    
    public var monthName:String {
        return monthName(forLocale: Locale.current)
    }
    
    public func monthName(forLocale locale: Locale) -> String {
        let formatter = dateFormatter(withLocale: locale)
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.month], from: self)
        return formatter.monthSymbols[dateComponents.month! - 1]
    }
    
    public var year:Int {
        return self.calendarComponents.year!
    }
    
    public var daysInMonth:Int {
        let firstDate = self.firstDateOfMonth
        let lastDate = self.lastDateOfMonth
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: firstDate, to: lastDate)
        return components.day! + 1
    }
    
    public static func numberOfDays(inMonth month:Int, ofYear year:Int) -> Int {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = month
        components.year = year
        
        guard let date = calendar.date(from: components) else {
            return NSNotFound
        }
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    public static func ordinality(forDate date:Date) -> String {
        let day = date.day
        switch day {
        case 1, 21, 31:
            return "st"
        case 2, 22:
            return "nd"
        case 3, 23:
            return "rd"
        default:
            return "th"
        }
    }
    
}
