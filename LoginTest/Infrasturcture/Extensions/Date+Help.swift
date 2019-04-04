//
//  Date+Helper.swift
//  Abstract
//
//  Created by Arturo Gamarra on 21/01/15.
//  Copyright (c) 2015 Abstract. All rights reserved.
//

import Foundation

// MARK: - Without Time
extension Date {
    
    public func withoutTime() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return calendar.date(from: components)!
    }
    
    public static var today:Date {
        return Date().withoutTime()
    }
}

// MARK: - Format
extension Date {
    
    public init?(stringDate:String, format:String) {
        if let date = DateFormatter.shared.date(fromString: stringDate, withFormat: format) {
            self.init(timeInterval:0, since:date)
        } else {
            return nil
        }
    }
    
    public func string(withFormat format:String) -> String {
        return DateFormatter.shared.string(fromDate: self, withFormat: format);
    }
    
    public func string(fromTemplate template:String) -> String {
        return DateFormatter.shared.string(fromDate: self, usingTemplate: template)
    }
    
}

// MARK: - Operation
extension Date {
    
    public func minutes(untilDate date:Date) -> Int {
        return Date.minutes(fromDate: self, toDate: date)
    }
    
    public static func minutes(fromDate initialDate:Date, toDate endDate:Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: initialDate, to: endDate)
        return components.minute!
    }
    
    public func hours(untilDate date:Date) -> Int {
        return Date.hours(fromDate: self, toDate: date)
    }
    
    public static func hours(fromDate initialDate:Date, toDate endDate:Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: initialDate, to: endDate)
        return components.hour!
    }
    
    public func days(untilDate date:Date) -> Int {
        return Date.days(fromDate: self, toDate: date)
    }
    
    public static func days(fromDate initialDate:Date, toDate endDate:Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: initialDate, to: endDate)
        return components.day!
    }
    
    public func months(untilDate date:Date) -> Int {
        return Date.months(fromDate: self, toDate: date)
    }
    
    public static func months(fromDate initialDate:Date, toDate endDate:Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: initialDate, to: endDate)
        return components.month!
    }
    
    public func date(byAddingMinutes minutes:Int) -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.minute = minutes
        return calendar.date(byAdding: components, to: self)!
    }
    
    public func date(byAddingHours hours:Int) -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.hour = hours
        return calendar.date(byAdding: components, to: self)!
    }
    
    public func date(byAddingDays days:Int) -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.day = days
        return calendar.date(byAdding: components, to: self)!
    }
    
    public func date(byAddingMonths months:Int) -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = months
        return calendar.date(byAdding: components, to: self)!
    }
}

