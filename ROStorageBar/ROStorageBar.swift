//
//  ROStorageBar.swift
//  RASCOcloud
//
//  Created by Robin Oster on 03/02/15.
//  Copyright (c) 2015 Robin Oster. All rights reserved.
//

import UIKit

class ROStorageBar : UIView {
    
    var storageBarValues = [ROStorageBarValue]()
    var totalSum:Float = 0.0
    var borderWidth:Float = 1.0
    var borderColor:UIColor = Helper.colorFromHexString("#333333")
    var displayInfos:Bool = true
    var unit:String?
    
    override init() {
        super.init()
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        drawStorageRects(context)
    }
    
    func drawStorageRects(context:CGContext) {
        
        CGContextSetLineWidth(context, CGFloat(borderWidth))
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        var currentX:Float = borderWidth
        var scale = (Float(self.frame.width) - 2 * borderWidth) / totalSum
        
        for storageBarValue in storageBarValues {
            var color = storageBarValue.color.CGColor
            
            let height:CGFloat = self.frame.height - 2 * CGFloat(borderWidth)
            let rectangle = CGRectMake(CGFloat(currentX), CGFloat(borderWidth), CGFloat(storageBarValue.value * scale),height)
            
            CGContextSetStrokeColorWithColor(context, borderColor.CGColor)
            CGContextAddRect(context, rectangle)
            CGContextStrokePath(context)
            CGContextSetFillColorWithColor(context, color)
            CGContextFillRect(context, rectangle)
            
            currentX += (storageBarValue.value * scale)
            
            if displayInfos {
                self.drawString(storageBarValue, rect: rectangle)
            }
        }
    }
    
    func drawString(storageBarValue:ROStorageBarValue, rect:CGRect) {
        
        let fontTitle = UIFont(name: "Helvetica Bold", size: 10.0)
        let fontValue = UIFont(name: "Helvetica Light", size: 10.0)
        
        let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Center
        let textColor = Helper.colorFromHexString("#000000")
        
        // Draw title
        if let actualFont = fontTitle {
            let textFontAttributes = [
                NSFontAttributeName: actualFont,
                NSForegroundColorAttributeName: textColor,
                NSParagraphStyleAttributeName: textStyle
            ]
            
            var titleStringToDraw:NSString = NSString(string: storageBarValue.title)
            var positionedTitleRect = CGRectMake(rect.origin.x, rect.origin.y + (self.frame.height/2 - 8), rect.width, rect.height)
            
            titleStringToDraw.drawInRect(positionedTitleRect, withAttributes: textFontAttributes)
        }
        
        // Draw value
        if let actualFont = fontValue {
            let textFontAttributes = [
                NSFontAttributeName: actualFont,
                NSForegroundColorAttributeName: textColor,
                NSParagraphStyleAttributeName: textStyle
            ]
        
            // Display the unit if its given
            var unitOfValue = self.unit ?? ""
            var valueStringToDraw:NSString = NSString(string: "\(storageBarValue.value) \(unitOfValue)")
            var positionedValueRect = CGRectMake(rect.origin.x, rect.origin.y + (self.frame.height/2 + 2), rect.width, rect.height)
            
            valueStringToDraw.drawInRect(positionedValueRect, withAttributes: textFontAttributes)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    func addStorageBarValue(storageBarValue:ROStorageBarValue) {
        storageBarValues.append(storageBarValue)
        self.totalSum += storageBarValue.value
        self.setNeedsDisplay()
    }
    
    struct ROStorageBarValue {
        var value:Float
        var title:String
        var color:UIColor
        
        init(value:Float, title:String, color:UIColor) {
            self.value = value
            self.title = title
            self.color = color
        }
    }
}