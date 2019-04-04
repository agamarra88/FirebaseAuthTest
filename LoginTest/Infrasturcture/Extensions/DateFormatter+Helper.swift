//
//  DateFormatter+Singleton.swift
//  Abstract
//
//  Created by Arturo Gamarra on 16/01/15.
//  Copyright (c) 2015 Abstract. All rights reserved.
//

import Foundation

extension DateFormatter {

    public static let shared = DateFormatter()
    
    // MARK: - Date to String
    public func string(fromDate date:Date, withFormat format:String, locale:Locale? = nil) -> String {
        self.dateFormat = format
        self.timeZone = TimeZone.autoupdatingCurrent
        self.locale = locale ?? Locale(identifier: "en_US_POSIX")
        let dateString = self.string(from: date)
        return dateString
    }
    
    public func string(fromDate date:Date, usingTemplate template:String, locale:Locale? = nil) -> String {
        let workLocale = locale ?? Locale.current
        guard let format = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: workLocale) else {
            return ""
        }
        return string(fromDate: date, withFormat:format, locale:locale)
    }
    
    
    // MARK: - String to Date
    public func date(fromString dateString:String, withFormat format:String, locale:Locale? = nil) -> Date? {
        self.dateFormat = format
        self.timeZone = TimeZone.autoupdatingCurrent
        self.locale = locale ?? Locale(identifier: "en_US_POSIX")
        let date = self.date(from: dateString)
        return date;
    }
    
    public func date(fromString dateString:String, usingTemplate template:String, locale:Locale? = nil) -> Date? {
        let workLocale = locale ?? Locale.current
        guard let format = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: workLocale) else {
            return nil
        }
        return date(fromString: dateString, withFormat: format, locale: locale)
    }

}
