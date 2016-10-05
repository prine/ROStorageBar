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

        storageBar.add(0.2, title: "Apps", color: UIColor(red: 200/255.0, green: 66/255.0, blue: 60/255.0, alpha: 1.0))
        storageBar.add(0.15, title: "Documents", color: UIColor(red: 158/255.0, green: 187/255.0, blue: 102/255.0, alpha: 1.0))
        storageBar.add(0.21, title: "Photos", color: UIColor(red: 236/255.0, green: 119/255.0, blue: 79/255.0, alpha: 1.0))
        storageBar.add(0.3, title: "Movies", color: UIColor(red: 196/255.0, green: 21/255.03, blue: 140/255.0, alpha: 1.0))
        
        // Or if you want to use directly the struct to add an item
        storageBar.addStorageBarValue(ROStorageBarValue(value: 0.6, title: "Backups", color: UIColor(red: 247/255.0, green: 168/255.0, blue: 159/255.0, alpha: 1.0)))
        
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

