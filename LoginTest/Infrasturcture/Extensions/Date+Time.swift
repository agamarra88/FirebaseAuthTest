//
//  Date+Time.swift
//  Abstract
//
//  Created by Arturo Gamarra on 10/23/17.
//  Copyright © 2017 Abstract. All rights reserved.
//

import Foundation

extension Date {
    
    // MARK: - Public
    public var timeComponents:DateComponents {
        let calendar = Calendar.current
        return calendar.dateComponents([.hour, .minute, .second], from: self)
    }
    
    public var hours:Int {
        return self.timeComponents.hour!
    }
    
    public var minutes:Int {
        return self.timeComponents.minute!
    }
    
    public var seconds:Int {
        return self.timeComponents.second!
    }
}
