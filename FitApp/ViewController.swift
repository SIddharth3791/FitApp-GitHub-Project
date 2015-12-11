//
//  ViewController.swift
//  FitApp
//
//  Created by Siddharth Patel on 11/4/15.
//  Copyright © 2015 Siddharth Patel. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import MapKit
import CoreLocation

class ViewController: UIViewController,PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate{
    
    var logInViewController: PFLogInViewController = PFLogInViewController()
    var signUpViewController: PFSignUpViewController! = PFSignUpViewController()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        let testObject = PFObject(className: "TestObject")
        testObject["Siddharth Has Done"] = "bar"
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        self.LoginsetUp()
    }
    
    //Marks: Parse Login
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool
    {
        if( !username.isEmpty || !password.isEmpty)
            {
                return true
            }
        else
            {
            return false
            }
        
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?)
    {
        print("Failed to login")
    }
    
    
    
    //Marks: Parse SignUp
    
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?)
    {
        print("Failed to sign up")
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController)
    {
        print("User Canceled SignUp")
    }
    
    // Marks: Actions
    
    @IBAction func simpleActionSender(Sender: AnyObject)
    {
        self.presentViewController(self.logInViewController, animated: true, completion: nil)
    }
    
    //Marks: Logout Action 
    
    @IBAction func LogOut(sender: AnyObject)
    {
        PFUser.logOut()
        
        self.LoginsetUp()
    }




    //Marks : Log in details Validation
    
    func LoginsetUp()
        {
        if (PFUser.currentUser() == nil)
            {
               let logInViewController = PFLogInViewController()
                logInViewController.delegate = self
                
                let signUpViewController = PFSignUpViewController()
                signUpViewController.delegate = self
                
                logInViewController.signUpController = signUpViewController
              self.presentViewController(logInViewController, animated: true, completion: nil)
                
               /** self.logInViewController.fields = [.UsernameAndPassword,  .LogInButton,  .SignUpButton,  //.PasswordForgotten,
                .DismissButton]
                let LogInLogoTitle = UILabel()
                LogInLogoTitle.text = "FitApp"
                self.logInViewController.logInView?.logo = LogInLogoTitle
                self.logInViewController.delegate = self
                let signUpLogoTitle = UILabel()
                signUpLogoTitle.text = "New Customer"
                self.signUpViewController.signUpView?.logo = signUpLogoTitle
                self.signUpViewController.delegate = self
                self.logInViewController.signUpController = self.signUpViewController **/
            }

        }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //marks: Location delegate Methods
    
}

