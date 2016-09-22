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
    @IBOutlet weak var previousBMI: UILabel!
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        getPreviousBMI()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CountBMI(_ sender: AnyObject) {
        
        
//marks:- Get Height and weight from textField
        let h = Double(HeightTxt.text!)
        let w = Double(WeightTxt.text!)
//Marks:- PFUser to know who is logged in and can save on cloud
        let BMImodel = BMICounting(height: h!, weight: w!)
        ResultBMITxt.text = String(format:"%.2f",BMImodel.bmi())
        
        if let pUserName = PFUser.current()?["username"] as? String{
// Marks:- Anything under 18 BMI..
            if (BMImodel.bmi() < 18.5)
            {
                self.Bmi1InfoTxt.text =  pUserName + " You Fall Under";
                Bmi2InfoTxt.text = "UNDERWEIGHT";
                Bmi3InfoTxt.text = "Category";
            }else if (BMImodel.bmi() >= 18.6 && BMImodel.bmi() <= 24.9)
// Marks:- Anything under 18 to 24.9 BMI..
            {
                self.Bmi1InfoTxt.text = pUserName + " You Fall Under";
                Bmi2InfoTxt.text = "NORMAL";
                Bmi3InfoTxt.text = "Category";
            } else if (BMImodel.bmi() >= 25 && BMImodel.bmi() <= 29.9)
// Marks:- Anything under 25 to 29.9 BMI..
            {
                self.Bmi1InfoTxt.text = pUserName + " You Fall Under";
                Bmi2InfoTxt.text = "OVERWEIGHT";
                Bmi3InfoTxt.text = "Category";
            }else
// Marks:- Anything under 30 BMI plus...
            {
                self.Bmi1InfoTxt.text = pUserName + " You Fall Under";
                Bmi2InfoTxt.text = "OBESITY";
                Bmi3InfoTxt.text = "Category";
            }
            
           
            let User = PFUser.current()
            User!["BMI"] = ResultBMITxt.text
            User?.saveInBackground()
        }
    }
    
    func dismissKeyboard() {
//Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//Marks:- Touch screen to drop Number pad..........
        WeightTxt.resignFirstResponder()
        HeightTxt.resignFirstResponder()
    }

    func getPreviousBMI()
    {
        let findPrData: PFQuery = PFQuery(className: "_User")
        findPrData.whereKey("username", equalTo: PFUser.current()!.username!)
        findPrData.whereKeyExists("BMI")
        findPrData.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]?
                {
                    for object in objects
                    {
                        let oldBMILoad = object.value(forKey: "BMI") as! String
                        self.previousBMI.text = oldBMILoad
                    }
                }
            }
        })

    }
}
