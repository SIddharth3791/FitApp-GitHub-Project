//
//  ResetPasswordViewController.swift
//  FitApp
//
//  Created by Siddharth Patel on 11/14/15.
//  Copyright © 2015 Siddharth Patel. All rights reserved.
//

import Foundation
import UIKit
import Parse

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBAction func passwordReset(_ sender: AnyObject) {
        let email = self.emailField.text
        let finalEmail = email!.trimmingCharacters(in: CharacterSet.whitespaces)
        
        // Send a request to reset a password
        PFUser.requestPasswordResetForEmail(inBackground: finalEmail)
        
        let alert = UIAlertController (title: "Password Reset", message: "An email containing information on how to reset your password has been sent to " + finalEmail + ".", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
