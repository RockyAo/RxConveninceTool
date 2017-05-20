//
//  CLLocationManager+Rx.swift
//  RxConveninceTool
//
//  Created by Rocky on 2017/5/20.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

extension Reactive where Base:CLLocationManager{
    
    var delegate:DelegateProxy{
        
        return RxCLLocationManagerDelegateProxy.proxyForObject(base)
    }
    
    
    var didUpdateLocations:Observable<[CLLocation]>{
        
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate.locationManager(_:didUpdateLocations:)))
            .map{ parameters in
                
                return parameters[1] as! [CLLocation]
        }
    }
}

class RxCLLocationManagerDelegateProxy: DelegateProxy,CLLocationManagerDelegate,DelegateProxyType {
    
    static func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
        
        let  locationManager : CLLocationManager = object as! CLLocationManager
        
        locationManager.delegate = delegate as? CLLocationManagerDelegate
        
    }
    
    static func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
        
        let locationManager:CLLocationManager = object as! CLLocationManager
        
        return locationManager.delegate
    }
    
    
}

