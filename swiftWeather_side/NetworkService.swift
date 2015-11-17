//
//  NetworkService.swift
//  swiftWeather_side
//
//  Created by test on 11/16/15.
//  Copyright © 2015 Mrtang. All rights reserved.
//

import Foundation
import CoreLocation

import SwiftyJSON

class NetworkService {
    typealias WeatherCompletionHandler = (Weather? , Error?) -> Void
    private let baseUrl = "http://api.openweathermap.org/data/2.5/forecast"
    
    func retrieveWeatherInfo(location:CLLocation,completionHandler:WeatherCompletionHandler) {
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfig)
        
        guard let url = generateRequestURL(location) else {
            completionHandler(nil,Error(errorType:Error.Code.URLError))
            return
        }
        
        print(url)
        let requst = NSURLRequest(URL: url)
        let task = session.dataTaskWithRequest(requst) { (data, response, error) -> Void in
            if error != nil {
                completionHandler(nil,Error(errorType:Error.Code.NetworkRequestFailed))
                return
            }
            
            guard let wappeddata = data else {
                completionHandler(nil,Error(errorType:Error.Code.JSONSerializationFailed))
                return
            }
            let json = JSON(data:wappeddata)
            
            guard let tempDegrees = json["list"][0]["main"]["temp"].double,
                        country:String = json["city"]["country"].stringValue,
                        city: String = json["city"]["name"].stringValue,
                        weatherCode: Int = json["list"][0]["weather"][0]["id"].intValue,
                        dayORnight: String = json["list"][0]["weather"][0]["icon"].stringValue
            else {
                completionHandler(nil,Error(errorType:Error.Code.JSONParsingFailed))
                return
            }
            
            var weatherBuild = WeatherBuild()
            let weatherIcon = WeatherIcon(code: weatherCode, dayORnight: dayORnight)
            weatherBuild.location = city
            weatherBuild.weatherIcon = weatherIcon.iconString
            let temparature = Temperatrue(country: country, temperature: tempDegrees).temperatrueString
            weatherBuild.temperatrue = temparature
            
            //下面获取forecast
            var forecastViewModels:[ForecastViewModel] = []
            for index in 0...3 {
                guard let tempDegrees = json["list"][index]["main"]["temp"].double,
                    country:String = json["city"]["country"].stringValue,
                    weatherCode: Int = json["list"][index]["weather"][0]["id"].intValue,
                    dayORnight: String = json["list"][index]["weather"][0]["icon"].stringValue,
                    dt:Int = json["list"][index]["dt"].intValue
                    else {
                        completionHandler(nil,Error(errorType:Error.Code.JSONParsingFailed))
                        return
                }
                var forecastViewModel = ForecastViewModel()
                let timeString = TimeFormat(micSec: dt).timeString
                forecastViewModel.timeString = Observable(timeString)
                
                let weatherIcon = WeatherIcon(code: weatherCode, dayORnight: dayORnight)
                forecastViewModel.weatherIcon = Observable(weatherIcon.iconString!)
                
                let temparature = Temperatrue(country: country, temperature: tempDegrees).temperatrueString
                forecastViewModel.tempareture = Observable(temparature)
                
                forecastViewModels.append(forecastViewModel)
            }
            
            weatherBuild.forecastViewModelArray = forecastViewModels
                        
            completionHandler(weatherBuild.build(),nil)
            
            
        } //闭包
        task.resume()
        
    } // end retrieveWeatherInfo
    
    private func generateRequestURL(location:CLLocation) ->NSURL? {
        guard let components = NSURLComponents(string: baseUrl) else {
            return nil
        }
        components.queryItems = [NSURLQueryItem(name: "lat", value: String(location.coordinate.latitude)),
                                NSURLQueryItem(name: "lon", value: String(location.coordinate.longitude)),
                                NSURLQueryItem(name: "appid", value: String("c495719d5c411bc398d3a3afccb1851f"))
                                ]
        return components.URL
        
    }//generateRequestURL
}