//
//  MKMapView+Rx.swift
//  RxConveninceTool
//
//  Created by Rocky on 2017/5/20.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import MapKit
import RxSwift
import RxCocoa


class RxMKMapViewDelegateProxy: DelegateProxy,MKMapViewDelegate,DelegateProxyType {
    
    static func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
        
        let mapView:MKMapView = (object as? MKMapView)!
        
        return mapView.delegate
    }
    
    static func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
        
        let mapView:MKMapView = (object as? MKMapView)!
        mapView.delegate = delegate as? MKMapViewDelegate
    }
}

extension Reactive where Base:MKMapView{
    
    public var delegate:DelegateProxy{
        
        return RxMKMapViewDelegateProxy.proxyForObject(base)
    }
    
    public func setDelegate(_ delegate:MKMapViewDelegate) -> Disposable{
        
        return RxMKMapViewDelegateProxy.installForwardDelegate(delegate, retainDelegate: false, onProxyForObject: self.base)
    }
    
    var overlays:UIBindingObserver<Base,[MKOverlay]>{
        
        return UIBindingObserver(UIElement: self.base, binding: { (mapView, overlays) in
            
            mapView.removeOverlays(mapView.overlays)
            mapView.addOverlays(overlays)
        })
    }
    
}
