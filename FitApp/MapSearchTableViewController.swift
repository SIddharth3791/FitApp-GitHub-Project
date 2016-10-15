//
//  MapSearchTableViewController.swift
//  GuruFitApp
//
//  Created by Siddharth Patel on 10/6/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import UIKit
import MapKit
import Parse
import ParseUI
import CoreLocation

class MapSearchTableViewController: UITableViewController,MKMapViewDelegate, CLLocationManagerDelegate {

    weak var handleMapSearchDelegate: HandleMapSearch?
    var matchingItems: [MKMapItem] = []
    var mapView: MKMapView?
    var MapFoodPlace = [String]()
    var UserCaloriesConsumedInEnd: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    var FoodItem = [String]()
    var FoodItemCal = [String]()
    
    func parseAddress(_ selectedItem:MKPlacemark) -> String {
        
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil &&
            selectedItem.thoroughfare != nil) ? " " : ""
        
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) &&
            (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil &&
            selectedItem.administrativeArea != nil) ? " " : ""
        
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        
        return addressLine
    }
    
}

extension MapSearchTableViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else { return }

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
                            let request = MKLocalSearchRequest()
                            request.naturalLanguageQuery = searchBarText
                        
                            if searchBarText == "Subway"||searchBarText == "Chick-Fil-A" || searchBarText == "Chick-fil-A" || searchBarText == "subway"  {
                            request.region = mapView.region
                            let search = MKLocalSearch(request: request)
                            
                            search.start { response, _ in
                                guard let response = response else {
                                    return
                                }
                                
                                self.matchingItems = response.mapItems
                                self.tableView.reloadData()
                                }
                            
                            }
                        }
                        else if (Int(self.UserCaloriesConsumedInEnd)! >= 500 && Int(self.UserCaloriesConsumedInEnd)! <= 1000)
                        {
                        let request = MKLocalSearchRequest()
                        request.naturalLanguageQuery = searchBarText
                        
                        if searchBarText == "Subway"||searchBarText == "Chick-Fil-A" || searchBarText == "Chick-fil-a" || searchBarText == "subway" || searchBarText == "Arby's" || searchBarText == "Arbys" || searchBarText == "McDonalds" || searchBarText == "Mcdonalds" {
                            request.region = mapView.region
                            let search = MKLocalSearch(request: request)
                            
                            search.start { response, _ in
                                guard let response = response else {
                                    return
                                }
                                
                                self.matchingItems = response.mapItems
                                self.tableView.reloadData()
                            }
                        }
                    }
                      else if (Int(self.UserCaloriesConsumedInEnd)! >= 1000 && Int(self.UserCaloriesConsumedInEnd)! <= 1500)
                    {
                        let request = MKLocalSearchRequest()
                        request.naturalLanguageQuery = searchBarText
                        
                        if searchBarText == "Subway"||searchBarText == "Chick-Fil-A" || searchBarText == "Chick-fil-a" || searchBarText == "subway" || searchBarText == "Arby's" || searchBarText == "Arbys" || searchBarText == "McDonalds" || searchBarText == "Mcdonalds" {
                            request.region = mapView.region
                            let search = MKLocalSearch(request: request)
                            
                            search.start { response, _ in
                                guard let response = response else {
                                    return
                                }
                                
                                self.matchingItems = response.mapItems
                                self.tableView.reloadData()
                            }
                        }


                        }else
                        {
                            let request = MKLocalSearchRequest()
                            request.naturalLanguageQuery = searchBarText
                            
                            if searchBarText == "Subway"||searchBarText == "Chick-Fil-A" || searchBarText == "Chick-fil-a" || searchBarText == "subway" || searchBarText == "Arby's" || searchBarText == "Arbys" || searchBarText == "McDonalds" || searchBarText == "Mcdonalds" || searchBarText == "Panda Express" || searchBarText == "Pizza Hut" {
                                request.region = mapView.region
                                let search = MKLocalSearch(request: request)
                                
                                search.start { response, _ in
                                    guard let response = response else {
                                        return
                                    }
                                    
                                    self.matchingItems = response.mapItems
                                    self.tableView.reloadData()
                                }
                            }
                        }
                }
            }
        }
    })
        
    }
}

extension MapSearchTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let selectedItem = matchingItems[(indexPath as NSIndexPath).row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem)
        return cell
    }
    
}

extension MapSearchTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[(indexPath as NSIndexPath).row].placemark
        handleMapSearchDelegate?.dropPinZoomIn(selectedItem)
        dismiss(animated: true, completion: nil)
    }
    
}



