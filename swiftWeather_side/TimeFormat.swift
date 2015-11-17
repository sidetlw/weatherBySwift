//
//  TimeFormat.swift
//  swiftWeather_side
//
//  Created by test on 11/17/15.
//  Copyright © 2015 Mrtang. All rights reserved.
//

import Foundation

class TimeFormat {
    var timeString:String!
    
    init(micSec:Int) {
        let ts = Double( micSec )
        let  formatter = NSDateFormatter ()
        formatter.dateFormat = "HH:MM"
        let date = NSDate(timeIntervalSince1970 : ts)
        self.timeString = formatter.stringFromDate(date)
    }
}