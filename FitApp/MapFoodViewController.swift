//
//  MapFoodViewController.swift
//  GuruFitApp
//
//  Created by Siddharth Patel on 10/6/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Parse
import ParseUI

protocol HandleMapSearch: class {
    func dropPinZoomIn(_ placemark:MKPlacemark)
}


class MapFoodViewController: UIViewController{
    
    
    @IBOutlet weak var FoodAllowedEatLabel: UILabel!
    var selectedPin: MKPlacemark?
    var resultSearchController: UISearchController!
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    var MapFoodPlace = [String]()
    var UserCaloriesConsumedInEnd: String = ""
    
    // Get Food Details and Calories 
    var PinFoodDetails = [String]()
    var PinName :String = "McDonals"

   
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
   //get remaining claories and display food option on Viewcontroller
        getRemainingCaloriesforUser()
  //Map user location and function
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! MapSearchTableViewController
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        
        
       
        
        
    }
    func getRemainingCaloriesforUser()
    {
        let findCalRemainData: PFQuery = PFQuery(className: "_User")
        findCalRemainData.whereKey("username", equalTo: PFUser.current()!.username!)
        findCalRemainData.whereKeyExists("FoodCaloriesRemaining")
        findCalRemainData.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]?
                {
                    for object in objects
                    {
                        let oldCalLoad = object.value(forKey: "FoodCaloriesRemaining") as! String
                        self.UserCaloriesConsumedInEnd = oldCalLoad
                    // Conditions for User to select food depending on food option
                        
                        if Int(self.UserCaloriesConsumedInEnd)! < 500
                        
                        {
                             self.FoodAllowedEatLabel.text = "Subway, Chick-Fil-A"
                        }
                        else if (Int(self.UserCaloriesConsumedInEnd)! >= 500 && Int(self.UserCaloriesConsumedInEnd)! <= 1000)
                        {
                            self.FoodAllowedEatLabel.text = "Arby's, McDonalds,Subway, Chick-Fil-A"
                        } else if (Int(self.UserCaloriesConsumedInEnd)! >= 1000 && Int(self.UserCaloriesConsumedInEnd)! <= 1500)
                        {
                            self.FoodAllowedEatLabel.text = "Arby's, McDonalds,Subway, Chick-Fil-A"
                        }else
                        {
                            self.FoodAllowedEatLabel.text = "Panda Express, Pizza Hut, Arby's, McDonalds,Subway, Chick-Fil-A"
                        }
                        
                    }
                }
            }
        })
    }
    
    func getDirections(){
        guard let selectedPin = selectedPin else { return }
        let mapItem = MKMapItem(placemark: selectedPin)
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: launchOptions)
    }
}

extension MapFoodViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
    
}

extension MapFoodViewController: HandleMapSearch {
    
    func dropPinZoomIn(_ placemark: MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    
}

extension MapFoodViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        
        guard !(annotation is MKUserLocation) else { return nil }
        
        //let reuseId = "pin"
        //guard let pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView else { return nil }
        
        var pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "CustomAnnotationView")
            pinView.canShowCallout = true

        pinView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        pinView.pinTintColor = UIColor.red
        pinView.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
        button.setBackgroundImage(UIImage(named: "car"), for: UIControlState())
        button.addTarget(self, action: #selector(MapFoodViewController.getDirections), for: .touchUpInside)
        pinView.leftCalloutAccessoryView = button
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl){
        self.performSegue(withIdentifier: "PinDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?){
        var pinDetailsVC = MapPinFoodDataBaseViewController()
        let annotation = MKPointAnnotation()
        var foodtitle = String()
        annotation.title = selectedPin?.name
        pinDetailsVC = segue.destination as! MapPinFoodDataBaseViewController
        pinDetailsVC.Fooddatagiven = (selectedPin?.name)!
        
    }
    
}
