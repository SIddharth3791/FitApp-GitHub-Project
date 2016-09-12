//
//  BMICounting.swift
//  FitApp
//
//  Created by Siddharth Patel on 1/31/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import Foundation

class BMICounting{
    
    var height:Double
    var weight:Double
    
    
    init(height:Double, weight:Double)
    {
        self.height = height
        self.weight = weight
    }
    
    func bmi() -> Double{
//Marks:- Formula to get BMI count.
        return Double((weight/(height*height))*10000)
    }
}

