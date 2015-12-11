//
//  MapView.swift
//  FitApp
//
//  Created by Siddharth Patel on 11/6/15.
//  Copyright © 2015 Siddharth Patel. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var Map: MKMapView!
    let locationManger = CLLocationManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.locationManger.delegate = self
        self.locationManger.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManger.requestWhenInUseAuthorization()
        self.locationManger.startUpdatingLocation()
        self.Map.showsUserLocation = true
    }

    //Marks : Location delegate Method
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        let center = CLLocationCoordinate2DMake(location!.coordinate.latitude, location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        self.Map.setRegion(region, animated: true)
        self.locationManger.stopUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errors: " + error.localizedDescription)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
