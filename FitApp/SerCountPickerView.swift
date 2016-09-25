//
//  SerCountPickerView.swift
//  GuruFitApp
//
//  Created by Siddharth Patel on 9/22/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import Foundation
import UIKit

class SerCountPickerView: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource  {
    
    @IBOutlet weak var CountPicker: UIPickerView!
    @IBOutlet weak var ValueClickedButton: UIButton!
    
    @IBOutlet weak var ValueLabel: UILabel!
    
    var CounterData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.CountPicker.delegate = self
        self.CountPicker.dataSource = self
        
        CounterData = ["0","0.5","1","1.5","2","2.5","3","3.5"]
       
        CountPicker.isHidden = true
        ValueLabel.text = CounterData[0]
    
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
        
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return CounterData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CounterData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        ValueLabel.text = CounterData[row]
        CountPicker.isHidden = true
    }
    
    func textFieldShouldBeginEditing(textField:UITextField) -> Bool{
        
        CountPicker.isHidden = false
        return false
    }

    
    @IBAction func ValueButton(_ sender: AnyObject) {
        
            
    }
    
    
    
}
