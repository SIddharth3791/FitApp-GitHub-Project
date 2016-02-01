//
//  BMICountViewController.swift
//  FitApp
//
//  Created by Siddharth Patel on 1/31/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import UIKit

class BMICountViewController: UIViewController {

    @IBOutlet weak var WeightTxt: UITextField!
    @IBOutlet weak var HeightTxt: UITextField!
    @IBOutlet weak var ResultBMITxt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

}
