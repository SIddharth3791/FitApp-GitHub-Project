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



class MapViewController:UIViewController,MKMapViewDelegate, CLLocationManagerDelegate {
    
    
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
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.Map.setRegion(region, animated: true)
        self.locationManger.stopUpdatingLocation()
        
//Marks:- look for restaurant on Maps
        
        let request = MKLocalSearchRequest()
        
        request.naturalLanguageQuery = "mcdonalds";
   
        request.region = Map.region
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        request.region = MKCoordinateRegion(center: center, span: span)
        
        let Search = MKLocalSearch(request: request)
        Search.startWithCompletionHandler{(response: MKLocalSearchResponse?,error: NSError?) in for item in response!.mapItems as! [MKMapItem]
            {
                print("Restaurants name = \(item.name)")
                self.addPinToMapView(item.name!, latitude: item.placemark.location!.coordinate.latitude, longitude: item.placemark.location!.coordinate.longitude)
            }
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errors: " + error.localizedDescription)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
      
    }
    
//Marks:- look for restaurant annotation Pin on Maps
    
    func addPinToMapView(title: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = RestroAnnotation(coordinate: location, title: title )
        Map.addAnnotation(annotation)
    }
}
