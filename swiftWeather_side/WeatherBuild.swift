//
//  WeatherBuild.swift
//  swiftWeather_side
//
//  Created by test on 11/16/15.
//  Copyright © 2015 Mrtang. All rights reserved.
//

import Foundation

struct WeatherBuild {
    var location:String?
    var weatherIcon:String?
    var temperatrue:String?
    var forecastViewModelArray:[ForecastViewModel]?
    
    func build() -> Weather{
        return Weather(location:location!,weatherIcon:weatherIcon!,temperatrue:temperatrue!,forecastViewModelArray:forecastViewModelArray!)
    }

}