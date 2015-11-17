//
//  Temperatrue.swift
//  swiftWeather_side
//
//  Created by test on 11/16/15.
//  Copyright © 2015 Mrtang. All rights reserved.
//

import Foundation

class Temperatrue {
    var temperatrueString:String
    
    init(country:String,temperature:Double) {
        if country == "US" {
            //round 是四舍五入函数
            temperatrueString = String(round(((temperature - 273.15) * 1.8) + 32)) + "\u{f045}"
        }
        else {
            temperatrueString = String(round(temperature - 273.15)) + "\u{f03c}"
        }
    }
}