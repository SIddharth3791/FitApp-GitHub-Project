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


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // MArks : Parse Intilization
        
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("utWrDDYtwnHBrzXABz2af6ArUYZo2oE3hfHGtILv",
            clientKey: "JXzEUAlUk0xIsTsipzcUMFT8miwUp21ZbrsjAswE")
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        return true
    }
    
    func application(application: UIApplication, willChangeStatusBarFrame newStatusBarFrame: CGRect) {
        let windows = UIApplication.sharedApplication().windows
        
        for window in windows {
            window.removeConstraints(window.constraints)
        }
    }
    
    

    func applicationWillResignActive(application: UIApplication) {
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
    
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
    }

    func applicationWillTerminate(application: UIApplication) {
       
    }


}

