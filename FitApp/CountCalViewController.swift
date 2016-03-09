//
//  CountCalViewController.swift
//  FitApp
//
//  Created by Siddharth Patel on 3/9/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import Foundation
import UIKit

class CountCalViewController: UIViewController {

    //Marks:- UIlable to update according to Slider
    @IBOutlet weak var BreakFastCalLabel: UILabel!
    @IBOutlet weak var LunchCalLabel: UILabel!
    @IBOutlet weak var DinnerCalLabel: UILabel!
    @IBOutlet weak var SnacksCalLabel: UILabel!
    
    
    //marks:- Text feild for calories allowed to be consumed.
    @IBOutlet weak var MaxCalTextField: UITextField!
    
    //marks:- Text feild for calories consumed
    
    
    @IBOutlet weak var TotalCalLabel: UILabel!
    @IBOutlet weak var StatusLabel: UILabel!
    
    //Marks:- slider for breakfast, Lunch, Dinner & snacks
    @IBOutlet weak var BreakFastSlider: UISlider!
    @IBOutlet weak var LunchSlider: UISlider!
    @IBOutlet weak var DinnerSlider: UISlider!
    @IBOutlet weak var SnacksSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func BreakFastSlider(sender: AnyObject) {
        var MaxCal = (MaxCalTextField.text! as NSString).floatValue
        
        var sliderBreakfast = BreakFastSlider.value
        var slideLunch = LunchSlider.value
        var slideDinner = DinnerSlider.value
        var slideSnacks = SnacksSlider.value
        
        //Marks:- This show Cal consumed overall
        
        var SumOfAllSliderCal = sliderBreakfast + slideDinner + slideLunch + slideSnacks
        var GrandSumOfAllCal = SumOfAllSliderCal - MaxCal
       
        var SumOfAllSliderCalFormat: NSString = NSString(format: "%0.2f", GrandSumOfAllCal)
        TotalCalLabel.text = "\(SumOfAllSliderCalFormat)"
        
        if ( GrandSumOfAllCal > 0)
        {
            let info = "Crossed Your Daily Max Calories"
        StatusLabel.text = info
        }else
        {
            let info1 = ""
            StatusLabel.text = info1
        }
        //Marks:- This show Cal consumed in Breakfast only
        
        var BreakFastCaloriesConsumed = sliderBreakfast
        var totalCalFormat : NSString = NSString(format: "%00.02f", BreakFastCaloriesConsumed)
        
       BreakFastCalLabel.text = "\(totalCalFormat)"
    }
    
    @IBAction func LunchSlider(sender: AnyObject) {
        var MaxCal = (MaxCalTextField.text! as NSString).floatValue
        
        var sliderBreakfast = BreakFastSlider.value
        var slideLunch = LunchSlider.value
        var slideDinner = DinnerSlider.value
        var slideSnacks = SnacksSlider.value
        
        //Marks:- This show Cal consumed overall
        
        var SumOfAllSliderCal = sliderBreakfast + slideDinner + slideLunch + slideSnacks
        var GrandSumOfAllCal = SumOfAllSliderCal - MaxCal
        var SumOfAllSliderCalFormat: NSString = NSString(format: "%0.2f", GrandSumOfAllCal)
        TotalCalLabel.text = "\(SumOfAllSliderCalFormat)"
        
        //Marks:- This show Cal consumed in Breakfast only
        
        var caloriesConsumed = slideLunch
        var totalCalFormat: NSString = NSString(format: "%0.2f", caloriesConsumed)
        LunchCalLabel.text = "\(totalCalFormat)"
        
    }
    
    @IBAction func DinnerSlider(sender: AnyObject) {
        
        var MaxCal = (MaxCalTextField.text! as NSString).floatValue
        
        var sliderBreakfast = BreakFastSlider.value
        var slideLunch = LunchSlider.value
        var slideDinner = DinnerSlider.value
        var slideSnacks = SnacksSlider.value
        
        //Marks:- This show Cal consumed overall
        
        var SumOfAllSliderCal = sliderBreakfast + slideDinner + slideLunch + slideSnacks
        var GrandSumOfAllCal = SumOfAllSliderCal - MaxCal
        var SumOfAllSliderCalFormat: NSString = NSString(format: "%0.2f", GrandSumOfAllCal)
        TotalCalLabel.text = "\(SumOfAllSliderCalFormat)"
        
        //Marks:- This show Cal consumed in Breakfast only
        
        var caloriesConsumed = slideDinner
        var totalCalFormat: NSString = NSString(format: "%0.2f", caloriesConsumed)
        DinnerCalLabel.text = "\(totalCalFormat)"
        
    }
    
    @IBAction func SnacksSlider(sender: AnyObject) {
        
        var MaxCal = (MaxCalTextField.text! as NSString).floatValue
        
        var sliderBreakfast = BreakFastSlider.value
        var slideLunch = LunchSlider.value
        var slideDinner = DinnerSlider.value
        var slideSnacks = SnacksSlider.value
        
        //Marks:- This show Cal consumed overall
        
        var SumOfAllSliderCal = sliderBreakfast + slideDinner + slideLunch + slideSnacks
        var GrandSumOfAllCal = SumOfAllSliderCal - MaxCal
        var SumOfAllSliderCalFormat: NSString = NSString(format: "%0.2f", GrandSumOfAllCal)
        TotalCalLabel.text = "\(SumOfAllSliderCalFormat)"
        
        //Marks:- This show Cal consumed in Breakfast only
        
        var caloriesConsumed = slideSnacks
        var totalCalFormat: NSString = NSString(format: "%0.2f", caloriesConsumed)
        SnacksCalLabel.text = "\(totalCalFormat)"
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        MaxCalTextField.resignFirstResponder()
    }
    
}
