//
//  ViewController.swift
//  swiftWeather_side
//
//  Created by test on 11/15/15.
//  Copyright © 2015 Mrtang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var temparatureLabel: UILabel!
    @IBOutlet weak var weatherIconLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet var forecastViews: [ForecastView]!
    
    
    var weatherViewModel:WeatherViewModel? {
        didSet {
            weatherViewModel?.location.setDelegateAndInvork({ [unowned self] (value) -> Void in
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.locationLabel.text = value
                })
            })
            
            weatherViewModel?.weatherIcon.setDelegateAndInvork({ [unowned self] (value) -> Void in
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.weatherIconLabel.text = value
                })

            })
            
            weatherViewModel?.temperature.setDelegateAndInvork({ [unowned self] (value) -> Void in
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.temparatureLabel.text = value
                })

            })
            
            weatherViewModel?.forecastViewModelArray.setDelegateAndInvork({ [unowned self] (forecastViewModels) -> Void in
                for index in 0...self.forecastViews.count - 1 {
                    if forecastViewModels.count >= 4 {
                        self.forecastViews[index].setViewModel(forecastViewModels[index])
                    }
                }
            })
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weatherViewModel = WeatherViewModel()
        self.weatherViewModel?.startLocationService()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

