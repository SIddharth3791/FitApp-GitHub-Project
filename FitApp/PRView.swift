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
        if  let User = PFUser.currentUser()?["username"] as? String {
            self.UserTextLabel.text = User
        }
        
        //Scrolling view
        ScrollView.contentSize.height = 2000
        
        PFACL.setDefaultACL(PFACL(), withAccessForCurrentUser: true )
        PFUser.currentUser()!.saveInBackground()
}
    
    override func didReceiveMemoryWarning() {
    
  }
    
  //gets data from Parse according to Current User.
    func UpdatePrData()
    {
        // I need to make PR data visible after it is saved twice (second time Updated data is not showing)
             
        let findPrData: PFQuery = PFQuery(className: "PR_Table")
        findPrData.whereKey("UserName", equalTo: PFUser.currentUser()!.username!)
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
        findPrData.findObjectsInBackgroundWithBlock{
            (Objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil{
                if let objects = Objects as [PFObject]?
                {
                    for object in objects
                    {
                       let kmRowingLoad = object.valueForKey("KM_Rowing") as! String
                        self.RowingText.text = kmRowingLoad
                        
                        let mileRunningLoad = object.valueForKey("Mile_Running") as! String
                        self.RunText.text = mileRunningLoad
                        
                        let backSquatsLoad = object.valueForKey("Max_Squats") as! String
                        self.BackSquatText.text = backSquatsLoad
                        
                       let frontSquatsLoad = object.valueForKey("Max_FrontSquats") as! String
                        self.FrontSquatText.text = frontSquatsLoad
                       
                       let deadLiftsLoad = object.valueForKey("Max_DeadLifts") as! String
                        self.DeadLifttext.text = deadLiftsLoad
                       
                         let powerCleanLoad = object.valueForKey("PowerClean") as! String
                        self.PowerCleantext.text = powerCleanLoad
                        
                        let powerCleanJerkLoad = object.valueForKey("PowerCleanJerk") as! String
                        self.PowerCleanJerkText.text = powerCleanJerkLoad
                        
                        let powerSnatchLoad = object.valueForKey("PowerSnatch") as! String
                        self.PowerSnatchText.text = powerSnatchLoad
                        
                        let pushUpsLoad = object.valueForKey("Min_PushUps") as! String
                        self.PushUpsText.text = pushUpsLoad
                        
                        let pullUpsLoad = object.valueForKey("Max_PullUps") as! String
                        self.PullUpsText.text = pullUpsLoad
                        
                        let burpeeLoad = object.valueForKey("Max_Burpees") as! String
                        self.BurpeesText.text = burpeeLoad
                        
                        let benchPressLoad = object.valueForKey("Max_BenchPress") as! String
                        self.BenchPresstext.text = benchPressLoad
                        
                        let murphyLoad = object.valueForKey("Murphy") as! String
                        self.MurphyText.text = murphyLoad
                        
                        let franLoad = object.valueForKey("Fran") as! String
                        self.FranText.text = franLoad
                        
                        
                    }
                }
                else
                {
                    print ("error")
                }
            }
        }
        
    }

    
    @IBAction func SaveDataButton(sender: AnyObject) {
        
       
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
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if (textField == PullUpsText){
        ScrollView.setContentOffset(CGPointMake(0, 250), animated: true)
        } else if (textField == BurpeesText) {
            ScrollView.setContentOffset(CGPointMake(0, 250), animated: true)
        } else if (textField == BenchPresstext)
        {
            ScrollView.setContentOffset(CGPointMake(0, 300), animated: true)
        }
        else if (textField == MurphyText)
        {
            ScrollView.setContentOffset(CGPointMake(0, 350), animated: true)
        }
        else if (textField == FranText)
        {
            ScrollView.setContentOffset(CGPointMake(0, 400), animated: true)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        ScrollView.setContentOffset(CGPointMake(0, 0), animated: true)
    }
}
