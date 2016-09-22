//
//  CFViewController.swift
//  FitApp
//
//  Created by Siddharth Patel on 11/18/15.
//  Copyright © 2015 Siddharth Patel. All rights reserved.
//

import Foundation
import UIKit

class CFViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var CFTableView: UITableView!

    
    var WODS = ["WorkOut Of Day","Time Keeper","PR's","About WOD"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WODS.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mycell = tableView.dequeueReusableCell(withIdentifier: "CFData", for: indexPath)
        mycell.textLabel?.text = WODS[(indexPath as NSIndexPath).row]
        return mycell

        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath as NSIndexPath).row{
        case 0: self.performSegue(withIdentifier: "ShowWod", sender: self)
        break;
        case 1: self.performSegue(withIdentifier: "TimeKeeper", sender: self);
        break;
        case 2: self.performSegue(withIdentifier: "PR's", sender: self);
        break;
        case 3: self.performSegue(withIdentifier: "AboutWod", sender: self)
        default:
            break
        }
    }
    
    
    @IBAction  func unwindForSegueMainCFView(_ unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
    }
}
