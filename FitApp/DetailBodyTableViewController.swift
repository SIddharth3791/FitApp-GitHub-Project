//
//  DetailBodyTableViewController.swift
//  FitApp
//
//  Created by Siddharth Patel on 2/25/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//


import UIKit
import ParseUI
import Parse

class DetailBodyTableViewController: UIViewController {
    
    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var workoutReps: UILabel!
    @IBOutlet weak var WorkoutImage: UIImageView!
    @IBOutlet weak var workoutDetails: UILabel!
    
    
    
    var label = String()
    var Reps = String()
    var details = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        TitleLabel.text = label
        workoutReps.text = Reps
        workoutDetails.text = details
        
        //random image
        
        let image : NSArray = [ UIImage(named: "BB1")!,
                                UIImage(named: "BB2")!,
                                UIImage(named: "BB3")!,
                                UIImage(named: "BB4")!,
                                UIImage(named: "BB5")!,
                                UIImage(named: "BB6")!,
                                UIImage(named: "BB7")!,
                                UIImage(named: "BB8")!,
                                UIImage(named: "BB9")!,
                                UIImage(named: "BB10")!,
                                UIImage(named: "BB11")!]
        
        //random image generating method
        let imagerange: UInt32 = UInt32(image.count)
        let randomimage = Int(arc4random_uniform(imagerange))
        let generatedimage: AnyObject = image.object(at: randomimage) as AnyObject
        self.WorkoutImage.image = generatedimage as? UIImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
