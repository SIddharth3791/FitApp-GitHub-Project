//
//  PRView.swift
//  FitApp
//
//  Created by Siddharth Patel on 11/20/15.
//  Copyright © 2015 Siddharth Patel. All rights reserved.
//

import Foundation
import UIKit
import Parse


class PRViewController: UIViewController, UITextFieldDelegate {
    
    var prData: NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var UserTextLabel: UILabel!
    @IBOutlet weak var RowingText: UITextField!
    @IBOutlet weak var RunText: UITextField!
    @IBOutlet weak var BackSquatText: UITextField!
    @IBOutlet weak var FrontSquatText: UITextField!
    @IBOutlet weak var DeadLifttext: UITextField!
    @IBOutlet weak var PowerCleantext: UITextField!
    @IBOutlet weak var PowerCleanJerkText: UITextField!
    @IBOutlet weak var PowerSnatchText: UITextField!
    @IBOutlet weak var PushUpsText: UITextField!
    @IBOutlet weak var PullUpsText: UITextField!
    @IBOutlet weak var BurpeesText: UITextField!
    @IBOutlet weak var BenchPresstext: UITextField!
    @IBOutlet weak var MurphyText: UITextField!
    @IBOutlet weak var FranText: UITextField!
 
    //Scroll View
    @IBOutlet weak var ScrollView: UIScrollView!
    
    //Add Button to save Indvidual data
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UpdatePrData()
        if  let User = PFUser.current()?["username"] as? String {
            self.UserTextLabel.text = User
        }
        
        //Scrolling view
        ScrollView.contentSize.height = 2000
        
        PFACL.setDefault(PFACL(), withAccessForCurrentUser: true )
        PFUser.current()!.saveInBackground()
}
    
    override func didReceiveMemoryWarning() {
    
  }
    
  //gets data from Parse according to Current User.
    func UpdatePrData()
    {
        // I need to make PR data visible after it is saved twice (second time Updated data is not showing)
        var message = [PFObject]()
        let findPrData: PFQuery = PFQuery(className: "PR_Table")
        findPrData.whereKey("UserName", equalTo: PFUser.current()!.username!)
        findPrData.whereKeyExists("KM_Rowing")
        findPrData.whereKeyExists("Mile_Running")
        findPrData.whereKeyExists("Max_Squats")
        findPrData.whereKeyExists("Max_FrontSquats")
        findPrData.whereKeyExists("Max_DeadLifts")
        findPrData.whereKeyExists("PowerClean")
        findPrData.whereKeyExists("PowerCleanJerk")
        findPrData.whereKeyExists("PowerSnatch")
        findPrData.whereKeyExists("Min_PushUps")
        findPrData.whereKeyExists("Max_PullUps")
        findPrData.whereKeyExists("Max_Burpees")
        findPrData.whereKeyExists("Max_BenchPress")
        findPrData.whereKeyExists("Murphy")
        findPrData.whereKeyExists("Fran")
        findPrData.findObjectsInBackground(block: {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil{
                if let objects = objects as [PFObject]?
                {
                    for object in objects
                    {
                       let kmRowingLoad = object.value(forKey: "KM_Rowing") as! String
                        self.RowingText.text = kmRowingLoad
                        
                        let mileRunningLoad = object.value(forKey: "Mile_Running") as! String
                        self.RunText.text = mileRunningLoad
                        
                        let backSquatsLoad = object.value(forKey: "Max_Squats") as! String
                        self.BackSquatText.text = backSquatsLoad
                        
                       let frontSquatsLoad = object.value(forKey: "Max_FrontSquats") as! String
                        self.FrontSquatText.text = frontSquatsLoad
                       
                       let deadLiftsLoad = object.value(forKey: "Max_DeadLifts") as! String
                        self.DeadLifttext.text = deadLiftsLoad
                       
                         let powerCleanLoad = object.value(forKey: "PowerClean") as! String
                        self.PowerCleantext.text = powerCleanLoad
                        
                        let powerCleanJerkLoad = object.value(forKey: "PowerCleanJerk") as! String
                        self.PowerCleanJerkText.text = powerCleanJerkLoad
                        
                        let powerSnatchLoad = object.value(forKey: "PowerSnatch") as! String
                        self.PowerSnatchText.text = powerSnatchLoad
                        
                        let pushUpsLoad = object.value(forKey: "Min_PushUps") as! String
                        self.PushUpsText.text = pushUpsLoad
                        
                        let pullUpsLoad = object.value(forKey: "Max_PullUps") as! String
                        self.PullUpsText.text = pullUpsLoad
                        
                        let burpeeLoad = object.value(forKey: "Max_Burpees") as! String
                        self.BurpeesText.text = burpeeLoad
                        
                        let benchPressLoad = object.value(forKey: "Max_BenchPress") as! String
                        self.BenchPresstext.text = benchPressLoad
                        
                        let murphyLoad = object.value(forKey: "Murphy") as! String
                        self.MurphyText.text = murphyLoad
                        
                        let franLoad = object.value(forKey: "Fran") as! String
                        self.FranText.text = franLoad
                        
                        
                    }
                }
                else
                {
                    print ("error")
                }
            }
        })
        
    }

    
    @IBAction func SaveDataButton(_ sender: AnyObject) {
        
       
        let rowing = RowingText.text
        let running = RunText.text
        let backSquat = BackSquatText.text
        let frontSquat = FrontSquatText.text
        let deadlift = DeadLifttext.text
        let powerClean = PowerCleantext.text
        let powerCleanJerk = PowerCleanJerkText.text
        let powerSnatch = PowerSnatchText.text
        let pushUps = PushUpsText.text
        let pullups = PullUpsText.text
        let burpees = BurpeesText.text
        let benchPress = BenchPresstext.text
        let murphy = MurphyText.text
        let fran = FranText.text
        
       let updatePRData = PFObject(className: "PR_Table")
        updatePRData["UserName"] = UserTextLabel.text
        updatePRData["KM_Rowing"] = rowing
        updatePRData["Mile_Running"] = running
        updatePRData["Max_Squats"] = backSquat
        updatePRData["Max_FrontSquats"] = frontSquat
        updatePRData["Max_DeadLifts"] = deadlift
        updatePRData["PowerClean"] = powerClean
        updatePRData["PowerCleanJerk"] = powerCleanJerk
        updatePRData["PowerSnatch"] = powerSnatch
        updatePRData["Min_PushUps"] = pushUps
        updatePRData["Max_PullUps"] = pullups
        updatePRData["Max_Burpees"] = burpees
        updatePRData["Max_BenchPress"] = benchPress
        updatePRData["Murphy"] = murphy
        updatePRData["Fran"] = fran
        updatePRData.saveInBackground()
            let alert = UIAlertView(title: "Success", message:"Your data has been saved", delegate: self, cancelButtonTitle: "OK")
            alert.show()
    
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == PullUpsText){
        ScrollView.setContentOffset(CGPoint(x: 0, y: 250), animated: true)
        } else if (textField == BurpeesText) {
            ScrollView.setContentOffset(CGPoint(x: 0, y: 250), animated: true)
        } else if (textField == BenchPresstext)
        {
            ScrollView.setContentOffset(CGPoint(x: 0, y: 300), animated: true)
        }
        else if (textField == MurphyText)
        {
            ScrollView.setContentOffset(CGPoint(x: 0, y: 350), animated: true)
        }
        else if (textField == FranText)
        {
            ScrollView.setContentOffset(CGPoint(x: 0, y: 400), animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        ScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}

