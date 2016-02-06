//
//  BMICountViewController.swift
//  FitApp
//
//  Created by Siddharth Patel on 1/31/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//
import Foundation
import UIKit
import Parse

class BMICountViewController: UIViewController {

    @IBOutlet weak var WeightTxt: UITextField!
    @IBOutlet weak var HeightTxt: UITextField!
    @IBOutlet weak var ResultBMITxt: UILabel!
    @IBOutlet weak var Bmi1InfoTxt: UILabel!
    @IBOutlet weak var Bmi2InfoTxt: UILabel!
    @IBOutlet weak var Bmi3InfoTxt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboard()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CountBMI(sender: AnyObject) {
        let h = Double(HeightTxt.text!)
        let w = Double(WeightTxt.text!)
        let BMImodel = BMICounting(height: h!, weight: w!)
        ResultBMITxt.text = String(format:"%.2f",BMImodel.bmi())
        
        if let pUserName = PFUser.currentUser()?["username"] as? String{
            if (BMImodel.bmi() < 18.0)
            {
                self.Bmi1InfoTxt.text = pUserName + " You Fall Under";
                Bmi2InfoTxt.text = "UNDERWEIGHT";
                Bmi3InfoTxt.text = "Category";
            }

        }
       
        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        WeightTxt.resignFirstResponder()
        HeightTxt.resignFirstResponder()
    }

}