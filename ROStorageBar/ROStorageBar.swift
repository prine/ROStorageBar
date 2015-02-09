//
//  ROStorageBar.swift
//  RASCOcloud
//
//  Created by Robin Oster on 03/02/15.
//  Copyright (c) 2015 Robin Oster. All rights reserved.
//

import UIKit

class ROStorageBar : UIView {
    
    private var storageBarValues = [ROStorageBarValue]()
    private var totalSum:Float = 0.0
    
    var borderWidth:Float = 1.0
    var borderColor:UIColor = UIColor.darkGrayColor()
    var titleFontSize = 10.0
    var valueFontSize = 10.0
    var displayTitle:Bool = true
    var displayValue:Bool = true
    var numberFormatter:NSNumberFormatter
    var unit:String?
    
    override init() {
        // Initilaize the default number formatter
        numberFormatter = NSNumberFormatter()
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.maximumFractionDigits = 1
        
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        // Initilaize the default number formatter
        numberFormatter = NSNumberFormatter()
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.maximumFractionDigits = 1
        
        super.init(coder:aDecoder)
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
            
            self.drawString(storageBarValue, rect: rectangle)
        }
    }
    
    func drawString(storageBarValue:ROStorageBarValue, rect:CGRect) {
        
        let fontTitle = UIFont(name: "Helvetica Bold", size: CGFloat(self.titleFontSize))
        let fontValue = UIFont(name: "Helvetica Light", size: CGFloat(self.valueFontSize))
        
        let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Center
        let textColor = UIColor.blackColor()
        
        var amountOfLineBreaks:Int?
        
        if displayTitle {
            if let actualFont = fontTitle {
                let textFontAttributes = [
                    NSFontAttributeName: actualFont,
                    NSForegroundColorAttributeName: textColor,
                    NSParagraphStyleAttributeName: textStyle
                ]
                
                var titleStringToDraw:NSString = NSString(string: storageBarValue.title)
                var positionedTitleRect = CGRectMake(rect.origin.x, rect.origin.y + (self.frame.height/2 - CGFloat(titleFontSize)), rect.width, rect.height)
            
                var titleWidth = countElements(storageBarValue.title) * Int(titleFontSize/2)
                
                amountOfLineBreaks = Int(ceil(Float(titleWidth) / Float(rect.width)))
                
                // Only display the title if there are less than 4 line breaks
                if amountOfLineBreaks < 4 {
                    titleStringToDraw.drawInRect(positionedTitleRect, withAttributes: textFontAttributes)
                }
            }
        }
        
        if displayValue {
            if let actualFont = fontValue {
                let textFontAttributes = [
                    NSFontAttributeName: actualFont,
                    NSForegroundColorAttributeName: textColor,
                    NSParagraphStyleAttributeName: textStyle
                ]
                
                // Amount of linebreaks the title will have
                var lineBreaks = amountOfLineBreaks ?? ((displayTitle) ? 2 : 0)
                var titleValuePadding = 2.0
                
                // Depending on the amount of line breaks the title has we need to calculate an offset for the y position
                var calculatedOffsetY = (self.frame.height/2 - CGFloat(titleFontSize) + (CGFloat(lineBreaks) * CGFloat(titleFontSize + titleValuePadding)))
            
                // Display the unit if its given
                var unitOfValue = self.unit ?? ""
                var valueStringToDraw:NSString = NSString(string: "\(numberFormatter.stringFromNumber(NSNumber(float:storageBarValue.value))!) \(unitOfValue)")
                var positionedValueRect = CGRectMake(rect.origin.x, rect.origin.y + calculatedOffsetY, rect.width, rect.height)
                
                if lineBreaks < 4 {
                    valueStringToDraw.drawInRect(positionedValueRect, withAttributes: textFontAttributes)
                }
            }
        }
    }
    
    func addStorageBarValue(storageBarValue:ROStorageBarValue) {
        storageBarValues.append(storageBarValue)
        self.totalSum += storageBarValue.value
        self.setNeedsDisplay()
    }
    
    func emptyStorageBar() {
        self.storageBarValues.removeAll(keepCapacity: false)
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