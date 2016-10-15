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
    
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var mapItems: [MKMapItem] = []
    var selectedPin: MKPlacemark?
 
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        locationManager.requestLocation()
    }
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        self.mapView.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()

       
        let request = MKLocalSearchRequest()
        
        request.naturalLanguageQuery = "mcdonalds";
        
        request.region = mapView.region
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        request.region = MKCoordinateRegion(center: center, span: span)
        
        let Search = MKLocalSearch(request: request)
        }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
        {
        print("Errors: " + error.localizedDescription)
        }
 

    func addPinToMapView(title: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees){
               let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                let annotation = RestroAnnotation(coordinate: location, title: title )
                mapView.addAnnotation(annotation)
        }
}
        

    




