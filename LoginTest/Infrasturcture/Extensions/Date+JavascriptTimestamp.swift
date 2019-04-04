//
//  NSDate+JavascriptTimestamp.swift
//  Abstract
//
//  Created by Arturo Gamarra on 5/8/16.
//  Copyright © 2016 Abstract. All rights reserved.
//

import UIKit

extension Date {

    // MARK: - Public
    public init(javascriptTimestamp:Double) {
        self.init(timeIntervalSince1970:javascriptTimestamp/1000)
    }
    
    public var javascriptTimestamp:Double {
        return Date.javascriptTimestamp(fromDate: self)
    }
    
    public static func javascriptTimestampNow() -> Double {
        return round(Date().timeIntervalSince1970*1000)
    }
    
    public static func javascriptTimestamp(fromDate date:Date) -> Double {
        return round(date.timeIntervalSince1970*1000)
    }
}
