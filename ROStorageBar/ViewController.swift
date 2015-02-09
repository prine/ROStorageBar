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

        storageBar.addStorageBarValue(ROStorageBar.ROStorageBarValue(value: 0.2, title: "Offline Data", color: Helper.colorFromHexString("#FFABAB")))
        storageBar.addStorageBarValue(ROStorageBar.ROStorageBarValue(value: 0.15, title: "Favorites", color: Helper.colorFromHexString("#FFD29B")))
        storageBar.addStorageBarValue(ROStorageBar.ROStorageBarValue(value: 0.3, title: "Test", color: Helper.colorFromHexString("#c3c3c3")))
        storageBar.addStorageBarValue(ROStorageBar.ROStorageBarValue(value: 0.8, title: "Free", color: Helper.colorFromHexString("#A8DBA8")))
        
        storageBar.unit = "GB"
        storageBar.displayTitle = true // Default value would anyway be true
        storageBar.displayValue = true // Default value would anyway be true
        storageBar.titleFontSize = 10.0
        storageBar.valueFontSize = 10.0
        
        var numberFormatter = NSNumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumIntegerDigits = 1
        
        storageBar.numberFormatter = numberFormatter
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        // Force the redraw. Otherwise the string is not correctly displayed
        storageBar.setNeedsDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

