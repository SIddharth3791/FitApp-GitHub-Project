//
//  AppDelegate.swift
//  FitApp
//
//  Created by Siddharth Patel on 11/4/15.
//  Copyright © 2015 Siddharth Patel. All rights reserved.
//

import UIKit
import Parse
import Bolts
import ParseUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // MArks : Parse Intilization
        
                
        //Connecting to Parse server to MonogoDB using AWS------------>
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = "utWrDDYtwnHBrzXABz2af6ArUYZo2oE3hfHGtILv"
            $0.clientKey = "JXzEUAlUk0xIsTsipzcUMFT8miwUp21ZbrsjAswE"
            $0.server = "http://ec2-50-112-23-88.us-west-2.compute.amazonaws.com/parse/"
        }
        // Swift 3.0
        Parse.initialize(with: configuration)
     
        
        /* parse website connection-------------->
         
         // Initialize Parse.
        Parse.setApplicationId("utWrDDYtwnHBrzXABz2af6ArUYZo2oE3hfHGtILv",
            clientKey: "JXzEUAlUk0xIsTsipzcUMFT8miwUp21ZbrsjAswE")
        //PFUser.enableRevocableSessionInBackground()
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpened(launchOptions: launchOptions)
        */
        return true
    }
    
    func application(_ application: UIApplication, willChangeStatusBarFrame newStatusBarFrame: CGRect) {
        let windows = UIApplication.shared.windows
        
        for window in windows {
            window.removeConstraints(window.constraints)
        }
    }
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
       
    }

    
    func application(application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
    }

}

