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

        storageBar.addStorageBarValue(ROStorageBar.ROStorageBarValue(value: 0.2, title: "Apps", color: Helper.colorFromHexString("#FFABAB")))
        storageBar.addStorageBarValue(ROStorageBar.ROStorageBarValue(value: 0.15, title: "Documents", color: Helper.colorFromHexString("#FFD29B")))
        storageBar.addStorageBarValue(ROStorageBar.ROStorageBarValue(value: 0.21, title: "Photos", color: Helper.colorFromHexString("#DDEBF9")))
        storageBar.addStorageBarValue(ROStorageBar.ROStorageBarValue(value: 0.3, title: "Movies", color: Helper.colorFromHexString("#c3c3c3")))
        storageBar.addStorageBarValue(ROStorageBar.ROStorageBarValue(value: 0.6, title: "Backups", color: Helper.colorFromHexString("#A8DBA8")))
        
        storageBar.unit = "GB"
        storageBar.displayTitle = false
        storageBar.displayValue = false
        storageBar.displayCaption = true
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

