//
//  LocationService.swift
//  swiftWeather_side
//
//  Created by test on 11/16/15.
//  Copyright © 2015 Mrtang. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationDataSourceDelegate {
    func locationDidUpdate(location:CLLocation)
}

class LocationService:NSObject {
    var delegate:LocationDataSourceDelegate?
    
   private let locationMannager:CLLocationManager
    
   override init() {
        locationMannager = CLLocationManager()
        super.init()
        locationMannager.delegate = self
        locationMannager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func requestLocation() {
        locationMannager.requestWhenInUseAuthorization()
        locationMannager.requestLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    @objc func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location:CLLocation? = locations[0] {
            print("Current location: \(location)")
            delegate?.locationDidUpdate(location!)
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error finding location: \(error.localizedDescription)")
    }
}