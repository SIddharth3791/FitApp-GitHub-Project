//
//  DismissSegue.swift
//  GuruFitApp
//
//  Created by Siddharth Patel on 9/30/16.
//  Copyright © 2016 Siddharth Patel. All rights reserved.
//

import UIKit
class DismissSegue:  UIStoryboardSegue {
    
    override func perform() {
        let sourceViewController = (self.source )
        let destinationController = (self.destination )
        let navigationController = sourceViewController.navigationController
        // Pop to root view controller (not animated) before pushing
        navigationController?.popToRootViewController(animated: true)
        navigationController?.pushViewController(destinationController, animated: true)
    }
}
