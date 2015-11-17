//
//  Weather.swift
//  swiftWeather_side
//
//  Created by test on 11/16/15.
//  Copyright © 2015 Mrtang. All rights reserved.
//

import Foundation

struct Weather {
    let location:String
    let weatherIcon:String
    let temperatrue:String
    
    let forecastViewModelArray:[ForecastViewModel]
}