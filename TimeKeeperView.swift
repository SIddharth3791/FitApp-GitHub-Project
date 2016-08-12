//
//  TimeKeeperView.swift
//  FitApp
//
//  Created by Siddharth Patel on 11/20/15.
//  Copyright © 2015 Siddharth Patel. All rights reserved.
//

import Foundation
import UIKit

class TimeKeeperViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var laps: [String]  = []
    var timer = NSTimer()
    var minutes: Int = 0
    var seconds: Int = 0
    var fraction: Int = 0
    var startstopWatch:Bool = true
    var addLap: Bool = false
    var StopWatchString: String = ""
    
    @IBOutlet weak var StopWatchLabel: UILabel!
    @IBOutlet weak var LapsTableView: UITableView!
    @IBOutlet weak var StartStopButton: UIButton!
    @IBOutlet weak var LapsButton: UIButton!
    
    //Tabata
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StopWatchLabel.text = "00:00.00"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Marks: Button action for start and stop
    @IBAction func StartStop(sender: AnyObject) {
        if startstopWatch == true{
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateStopWatch"), userInfo: nil, repeats: true)
            
            startstopWatch = false
            StartStopButton.setImage(UIImage(named: "Stop Button.png"), forState: UIControlState.Normal)
            LapsButton.setImage(UIImage(named: "Lap Button.png"), forState: UIControlState.Normal)
            addLap = true
        }else
        {
            timer.invalidate()
            startstopWatch = true
            StartStopButton.setImage(UIImage(named: "Start Button.png"), forState: .Normal)
            LapsButton.setImage(UIImage(named: "Reset Button.png"), forState: .Normal)
            
            addLap = false
        }
    }
    
    func updateStopWatch(){
        fraction += 1
        if fraction == 100{
            seconds += 1
            fraction = 0
        }
        if seconds == 60{
            minutes += 1
            seconds = 0
        }
        
        let fractionString = fraction > 9 ? "\(fraction)" : "0\(fraction)"
        let secondString = seconds > 9 ? "\(seconds)": "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        StopWatchString = "\(minutesString):\(secondString).\(fractionString)"
        StopWatchLabel.text = StopWatchString
        
        
    }
    
    //Marks: Button action to get laps
    
    @IBAction func Laps(sender: AnyObject) {
        
        if addLap == true{
            
            laps.insert(StopWatchString, atIndex: 0)
            LapsTableView.reloadData()
            
        }else
        {
            addLap = false
            LapsButton.setImage(UIImage(named: "Lap Button.png"), forState: .Normal)
            laps.removeAll(keepCapacity: false)
            LapsTableView.reloadData()
            fraction = 0
            seconds = 0
            minutes = 0
            
            StopWatchString = "00:00.00"
            StopWatchLabel.text = StopWatchString
            
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
    let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "LapCell")
        cell.backgroundColor = self.view.backgroundColor
        cell.textLabel?.text = "Lap \( laps.count - indexPath.row)"
        cell.detailTextLabel?.text = laps[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return laps.count
        
    }

}
