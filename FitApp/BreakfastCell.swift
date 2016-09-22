//
//  BreakfastCell.swift
//  GuruFitApp
//
//  Created by Siddharth Patel on 9/20/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import Foundation
import UIKit

class BreakfastCell : UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var BreakfastFoodCal: UILabel!
    @IBOutlet weak var BreakfastFoodLabel: UILabel!
    
    
    fileprivate var item : Item?
    fileprivate var delegate: ItemChangedDelegate?
    
    func setup(_ item: Item, delegate: ItemChangedDelegate?) {
        self.item = item
       BreakfastFoodLabel.text = item.name
        BreakfastFoodCal.text = String(item.amount)
        self.delegate = delegate
    }
    
}

protocol ItemChangedDelegate {
    func itemEditing(_ item: Item)
    func itemChanged(_ item: Item)
}

    
    

