//
//  Error.swift
//  swiftWeather_side
//
//  Created by test on 11/16/15.
//  Copyright © 2015 Mrtang. All rights reserved.
//

import Foundation

struct Error {
       enum Code:Int {
        case URLError = -6000
        case NetworkRequestFailed = -6001
        case JSONSerializationFailed = -6002
        case JSONParsingFailed = -6003
    }
    let errorType:Code
    

}