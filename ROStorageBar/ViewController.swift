//
//  ViewController.swift
//  ROStorageBar
//
//  Created by Robin Oster on 03/02/15.
//  Copyright (c) 2015 Robin Oster. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var storageBar:ROStorageBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        storageBar.add(0.2, title: "Apps", color: UIColor.black)
        storageBar.add(0.15, title: "Documents", color: UIColor.orange)
        storageBar.add(0.21, title: "Photos", color: UIColor.purple)
        storageBar.add(0.3, title: "Movies", color: UIColor.red)
        
        // Or if you want to use directly the struct to add an item
        storageBar.addStorageBarValue(ROStorageBarValue(value: 0.6, title: "Backups", color: UIColor.green))
        
        storageBar.unit = "GB"
        storageBar.displayTitle = false
        storageBar.displayValue = false
        storageBar.displayCaption = true
        storageBar.titleFontSize = 10.0
        storageBar.valueFontSize = 10.0
        
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumIntegerDigits = 1
        
        storageBar.numberFormatter = numberFormatter
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        // Force the redraw. Otherwise the string is not correctly displayed
        storageBar.setNeedsDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

