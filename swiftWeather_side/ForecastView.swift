//
//  ForecastView.swift
//  swiftWeather_side
//
//  Created by test on 11/15/15.
//  Copyright © 2015 Mrtang. All rights reserved.
//

import UIKit

@IBDesignable class ForecastView: UIView {
    var view:UIView!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherIconLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var viewModel:ForecastViewModel? {
        didSet {
            viewModel?.timeString.setDelegateAndInvork({ [unowned self] (value) -> Void in
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.timeLabel.text = value
                    })
                })
            
            viewModel?.weatherIcon.setDelegateAndInvork({ [unowned self] (value) -> Void in
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.weatherIconLabel.text = value
                    })
                })
            
            viewModel?.tempareture.setDelegateAndInvork({ [unowned self] (value) -> Void in
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.temperatureLabel.text = value
                    })
                })
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        view = self.loadViewFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view = self.loadViewFromNib()
     }
    
    func loadViewFromNib() -> UIView {
        let nib = UINib(nibName: "forecastView", bundle: NSBundle(forClass: self.dynamicType))
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        view.frame = self.bounds
        view.autoresizingMask = [.FlexibleHeight,.FlexibleWidth]
        self.addSubview(view)
        
        return view
    }
    
    func setViewModel(viewmodel:ForecastViewModel?) {
        self.viewModel = viewmodel
    }
}
