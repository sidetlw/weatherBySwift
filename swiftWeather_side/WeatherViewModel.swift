//
//  WeatherViewModel.swift
//  swiftWeather_side
//
//  Created by test on 11/16/15.
//  Copyright © 2015 Mrtang. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherViewModel {
    var location:Observable<String>
    var weatherIcon:Observable<String>
    var temperature:Observable<String>
    var forecastViewModelArray:Observable<[ForecastViewModel]>

    
    private var locationService:LocationService!
    private var networdService:NetworkService!
    
    init() {
        self.location = Observable<String>("")
        self.weatherIcon = Observable<String>("")
        self.temperature = Observable<String>("")
        self.forecastViewModelArray = Observable([])
    }
    
    func startLocationService() {
        self.locationService = LocationService()
        self.networdService = NetworkService()
        
        locationService.delegate = self
        locationService.requestLocation()
        
    }

    
    func update(weather:Weather) {
        self.location.value = weather.location
        self.weatherIcon.value = weather.weatherIcon
        self.temperature.value = weather.temperatrue
        self.forecastViewModelArray.value = weather.forecastViewModelArray
    }
    
    func update(error:Error) {
        switch error.errorType {
        case .URLError:
            print("Error: this is a bad url")
        case Error.Code.NetworkRequestFailed:
            print("Error: NetworkRequestFailed!!!")
        case Error.Code.JSONSerializationFailed:
            print("Error: JSONSerializationFailed!!!")
        case .JSONParsingFailed:
            print("Code: JSONParsingFailed!!!")
        }

        self.location.value = ""
        self.weatherIcon.value = ""
        self.temperature.value = ""
        self.forecastViewModelArray.value = []
    }
}



extension WeatherViewModel:LocationDataSourceDelegate{
    func locationDidUpdate(location:CLLocation) {
        networdService.retrieveWeatherInfo(location) { (weather, error) -> Void in
            if error != nil {
                self.update(error!)
                return
            } // end if
        
            guard let wrappedWeather = weather else {
                return
            }
            self.update(wrappedWeather)
        } // end block
    }
}


