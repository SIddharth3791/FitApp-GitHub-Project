//
//  AddFoodCaloriesViewController.swift
//  GuruFitApp
//
//  Created by Siddharth Patel on 9/15/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import UIKit

class AddFoodCaloriesViewController: UIViewController {

    var FoodtableView : FoodTableViewController?
    
    //Slider for breakfast, Lunch & Dinner
    
    @IBOutlet weak var FoodCalories: UILabel!
    @IBOutlet weak var FoodCalSlider: UISlider!
    
    
    var Ftitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //FoodTitle.text = Ftitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func FoodSlider(_ sender: AnyObject) {
        
        let SliderBreakfast = FoodCalSlider.value
        let sliderTotal = SliderBreakfast + 0
        let SumOfAllSliderCalFormat: NSString = NSString(format: "%02.0f", sliderTotal)
        
        FoodCalories.text = "\(SumOfAllSliderCalFormat)"
    }
    
    @IBAction func AddFoodButton(_ sender: UIButton) {
        let newFood: String = "Quick Calories"
        let NewFoodCal: String = FoodCalories.text!
        FoodtableView?.addFood(newfood: newFood, newcal: NewFoodCal)
        NSLog("----------->\(newFood)")
        NSLog("----------->\(NewFoodCal)")
        self.presentingViewController?.dismiss(animated:true, completion: nil)
    
        }

        
    }
    


