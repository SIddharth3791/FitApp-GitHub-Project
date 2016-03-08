//
//  RestroAnnotation.swift
//  FitApp
//
//  Created by Siddharth Patel on 1/30/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import UIKit
import MapKit


class RestroAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0,longitude: 0)
    var title: String?
    
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
        
    }
  
    }

