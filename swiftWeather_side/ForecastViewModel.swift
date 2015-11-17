//
//  ForecastViewModel.swift
//  swiftWeather_side
//
//  Created by test on 11/17/15.
//  Copyright © 2015 Mrtang. All rights reserved.
//

import Foundation

struct ForecastViewModel {
    var timeString:Observable<String>
    var weatherIcon:Observable<String>
    var tempareture:Observable<String>

    init() {
        timeString = Observable("")
        weatherIcon = Observable("")
        tempareture = Observable("")
    }
}