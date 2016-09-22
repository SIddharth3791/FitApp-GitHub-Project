//
//  WODDetailTableViewController.swift
//  FitApp
//
//  Created by Siddharth Patel on 1/13/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//
import UIKit
import Parse
import ParseUI

class WODDetailTableViewController: UIViewController {

    //Container to store the view table selected object 
    
    //var currentObject : PFObject?
   
    
    @IBOutlet weak var WODName: UILabel!
    
    @IBOutlet weak var WODDetails: UILabel!
    
    @IBOutlet weak var DetailWOD: UILabel!
    
    @IBOutlet weak var WODReps: UILabel!
    @IBOutlet weak var WODImages: PFImageView!
    
    
    var WODNameLabel = String()
    var WodDetailsLabel = String()
    var detailLabel = String()
    var WODrepsLabel = String()
    var WodImageFile: PFFile!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WODName.text = WODNameLabel
        WODDetails.text = WodDetailsLabel
        DetailWOD.text = detailLabel
        WODReps.text = WODrepsLabel
        //WODImages.file = WodImageFile
        
        
        //random image
        
        let image : NSArray = [ UIImage(named: "crossfit1")!,
                                UIImage(named: "crossfit2")!,
                                UIImage(named: "crossfit3")!,
                                UIImage(named: "crossfit4")!,
                                UIImage(named: "crossfit5")!,
                                UIImage(named: "crossfit6")!,
                                UIImage(named: "crossfit7")!,
                                UIImage(named: "crossfit8")!,
                                UIImage(named: "crossfit9")!]
        
        //random image generating method
        let imagerange: UInt32 = UInt32(image.count)
        let randomimage = Int(arc4random_uniform(imagerange))
        let generatedimage: AnyObject = image.object(at: randomimage) as AnyObject
        self.WODImages.image = generatedimage as? UIImage
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}
