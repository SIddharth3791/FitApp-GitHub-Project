//
//  CountCalViewController.swift
//  FitApp
//
//  Created by Siddharth Patel on 3/9/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import Foundation
import Parse
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
        
        let pUserName = PFUser.current()?["username"] as? String
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func BreakFastSlider(_ sender: AnyObject) {
        let MaxCal = (MaxCalTextField.text! as NSString).floatValue
        
        let sliderBreakfast = BreakFastSlider.value
        let slideLunch = LunchSlider.value
        let slideDinner = DinnerSlider.value
        let slideSnacks = SnacksSlider.value
        
        //Marks:- This show Cal consumed overall
        
        let SumOfAllSliderCal = sliderBreakfast + slideDinner + slideLunch + slideSnacks
        let GrandSumOfAllCal = SumOfAllSliderCal - MaxCal
       
        let SumOfAllSliderCalFormat: NSString = NSString(format: "%0.2f", GrandSumOfAllCal)
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
        
        let BreakFastCaloriesConsumed = sliderBreakfast
        let totalCalFormat : NSString = NSString(format: "%00.02f", BreakFastCaloriesConsumed)
        
       BreakFastCalLabel.text = "\(totalCalFormat)"
    }
    
    @IBAction func LunchSlider(_ sender: AnyObject) {
        let MaxCal = (MaxCalTextField.text! as NSString).floatValue
        
        let sliderBreakfast = BreakFastSlider.value
        let slideLunch = LunchSlider.value
        let slideDinner = DinnerSlider.value
        let slideSnacks = SnacksSlider.value
        
        //Marks:- This show Cal consumed overall
        
        let SumOfAllSliderCal = sliderBreakfast + slideDinner + slideLunch + slideSnacks
        let GrandSumOfAllCal = SumOfAllSliderCal - MaxCal
        let SumOfAllSliderCalFormat: NSString = NSString(format: "%0.2f", GrandSumOfAllCal)
        TotalCalLabel.text = "\(SumOfAllSliderCalFormat)"
        
        // Add StatuLabel code from Breakfast section to update status if you crossed your total cal limit.
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
        
        let caloriesConsumed = slideLunch
        let totalCalFormat: NSString = NSString(format: "%0.2f", caloriesConsumed)
        LunchCalLabel.text = "\(totalCalFormat)"
        
    }
    
    @IBAction func DinnerSlider(_ sender: AnyObject) {
        
        let MaxCal = (MaxCalTextField.text! as NSString).floatValue
        
        let sliderBreakfast = BreakFastSlider.value
        let slideLunch = LunchSlider.value
        let slideDinner = DinnerSlider.value
        let slideSnacks = SnacksSlider.value
        
        //Marks:- This show Cal consumed overall
        
        let SumOfAllSliderCal = sliderBreakfast + slideDinner + slideLunch + slideSnacks
        let GrandSumOfAllCal = SumOfAllSliderCal - MaxCal
        let SumOfAllSliderCalFormat: NSString = NSString(format: "%0.2f", GrandSumOfAllCal)
        TotalCalLabel.text = "\(SumOfAllSliderCalFormat)"
        
        //Marks:- This show Cal consumed in Breakfast only
        if ( GrandSumOfAllCal > 0)
        {
            let info = "Crossed Your Daily Max Calories"
            StatusLabel.text = info
        }else
        {
            let info1 = ""
            StatusLabel.text = info1
        }
        let caloriesConsumed = slideDinner
        let totalCalFormat: NSString = NSString(format: "%0.2f", caloriesConsumed)
        DinnerCalLabel.text = "\(totalCalFormat)"
        
    }
    
    @IBAction func SnacksSlider(_ sender: AnyObject) {
        
        let MaxCal = (MaxCalTextField.text! as NSString).floatValue
        
        let sliderBreakfast = BreakFastSlider.value
        let slideLunch = LunchSlider.value
        let slideDinner = DinnerSlider.value
        let slideSnacks = SnacksSlider.value
        
        //Marks:- This show Cal consumed overall
        
        let SumOfAllSliderCal = sliderBreakfast + slideDinner + slideLunch + slideSnacks
        let GrandSumOfAllCal = SumOfAllSliderCal - MaxCal
        let SumOfAllSliderCalFormat: NSString = NSString(format: "%0.2f", GrandSumOfAllCal)
        TotalCalLabel.text = "\(SumOfAllSliderCalFormat)"
        
        //Marks:- This show Cal consumed in Breakfast only
        if ( GrandSumOfAllCal > 0)
        {
            let info = "Crossed Your Daily Max Calories"
            StatusLabel.text = info
        }else
        {
            let info1 = ""
            StatusLabel.text = info1
        }
        let caloriesConsumed = slideSnacks
        let totalCalFormat: NSString = NSString(format: "%0.2f", caloriesConsumed)
        SnacksCalLabel.text = "\(totalCalFormat)"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        MaxCalTextField.resignFirstResponder()
    }
    
}
