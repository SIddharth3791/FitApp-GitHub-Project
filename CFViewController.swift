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
    
    
    @IBAction  func unwindForSegueCFView(unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
    }
    
    
    var WODS = ["WorkOut Of Day","Time Keeper","PR's","About WOD"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WODS.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let mycell = tableView.dequeueReusableCellWithIdentifier("CFData", forIndexPath: indexPath)
        mycell.textLabel?.text = WODS[indexPath.row]
        return mycell

        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row{
        case 0: self.performSegueWithIdentifier("ShowWod", sender: self)
        break;
        case 1: self.performSegueWithIdentifier("TimeKeeper", sender: self);
        break;
        case 2: self.performSegueWithIdentifier("PR's", sender: self);
        break;
        case 3: self.performSegueWithIdentifier("AboutWod", sender: self)
        default:
            break
        }

        
    }
    
    
    
    
}
