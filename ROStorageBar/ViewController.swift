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

        storageBar.addStorageBarValue(ROStorageBar.ROStorageBarValue(value: 0.4, title: "Offline Data", color: Helper.colorFromHexString("#FFABAB")))
        storageBar.addStorageBarValue(ROStorageBar.ROStorageBarValue(value: 0.2, title: "Favorites", color: Helper.colorFromHexString("#FFDAAB")))
        storageBar.addStorageBarValue(ROStorageBar.ROStorageBarValue(value: 0.3, title: "Test", color: Helper.colorFromHexString("#c3c3c3")))
        storageBar.addStorageBarValue(ROStorageBar.ROStorageBarValue(value: 0.8, title: "Free", color: Helper.colorFromHexString("#A8DBA8")))
        
        storageBar.unit = "GB"
        storageBar.displayInfos = true // Default value would anyway be true
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

