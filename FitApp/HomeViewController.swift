//
//  HomeViewController.swift
//  FitApp
//
//  Created by Siddharth Patel on 11/14/15.
//  Copyright © 2015 Siddharth Patel. All rights reserved.
//

import Foundation
import UIKit
import Parse

class HomeViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show the current visitor's username
        if let pUserName = PFUser.currentUser()?["username"] as? String {
            self.userNameLabel.text = "Welcome " + pUserName
        }
    }
    override func viewWillAppear(animated: Bool) {
        if (PFUser.currentUser() == nil) {
              dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LogIn")
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        }
    }
    
   /** override func viewWillAppear(animated: Bool) {
        if (PFUser.currentUser() == nil) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LogIn") 
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        }
    }**/
    
    @IBAction func logOutAction(sender: AnyObject){
        
        // Send a request to log out a user
        PFUser.logOut()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LogIn") 
            self.presentViewController(viewController, animated: true, completion: nil)
        })
        
    }
    
    @IBAction  func unwindForSegueHome(unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
    }
    
   
    
}