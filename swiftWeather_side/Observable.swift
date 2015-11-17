//
//  Observable.swift
//  swiftWeather_side
//
//  Created by test on 11/16/15.
//  Copyright © 2015 Mrtang. All rights reserved.
//


//这是一个对回调进行抽象的类，本来回调应该写在viewmodel中，那样就要写很多个回调，而因为回调形式比较统一，所以进行抽象

import Foundation

class Observable<T> {
    typealias delegateBlock = (T) -> Void
    
    var delegate:delegateBlock?
    
    func setDelegateAndInvork(block:delegateBlock) {
        self.delegate = block
        self.delegate?(value)
    }
    
    var value:T {
        didSet {
            self.delegate?(value)
        }
    }
    
    init(_ v:T) {
        value = v
    }
}