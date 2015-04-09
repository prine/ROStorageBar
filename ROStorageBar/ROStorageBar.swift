//
//  ROStorageBar.swift
//
// The MIT License (MIT)
//
// Copyright (c) 2015 Robin Oster (http://prine.ch)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import UIKit

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

class ROStorageBar : UIView {
    
    private var storageBarValues = [ROStorageBarValue]()
    private var totalSum:Float = 0.0
    private var height:CGFloat!
    
    var borderWidth:Float = 1.0
    var borderColor:UIColor = UIColor.darkGrayColor()
    var titleFontSize = 10.0
    var valueFontSize = 10.0
    var displayTitle:Bool = true
    var displayValue:Bool = true
    var displayCaption:Bool = false
    var numberFormatter:NSNumberFormatter
    var unit:String?
    
    init() {
        // Initilaize the default number formatter
        numberFormatter = NSNumberFormatter()
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.maximumFractionDigits = 1
        
        super.init(frame: CGRectZero)
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

        // Depending if the captions should be drawn or not set a different height
        height = displayCaption ? frame.height/2 : frame.height
        
        drawStorageRects(context)
        
        if displayCaption {
            drawCaption(context)
        }
    }
    
    func drawStorageRects(context:CGContext) {
        
        CGContextSetLineWidth(context, CGFloat(borderWidth))
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        var currentX:Float = borderWidth
        var scale = (Float(self.frame.width) - 2 * borderWidth) / totalSum
        
        for storageBarValue in storageBarValues {
            var color = storageBarValue.color.CGColor
            
            let height:CGFloat = self.height - 2 * CGFloat(borderWidth)
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
        
        let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
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
                var positionedTitleRect = CGRectMake(rect.origin.x, rect.origin.y + (self.height/2 - CGFloat(titleFontSize)), rect.width, rect.height)
            
                var titleWidth = count(storageBarValue.title) * (Int(titleFontSize/2)+1)
                
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
                var calculatedOffsetY = (self.height/2 - CGFloat(titleFontSize) + (CGFloat(lineBreaks) * CGFloat(titleFontSize + titleValuePadding)))
            
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
    
    func drawCaption(context:CGContext) {
        
        var offsetToBar:CGFloat = 10.0
        var offsetToRectangle:CGFloat = 5.0
        var offsetToTitle:CGFloat = 13.0
        var widthText:CGFloat = 80.0
        var heightText:CGFloat = 15.0
        var posX:CGFloat = 0.0
        var posY:CGFloat = self.height + offsetToBar
        var sizeRect:CGFloat = 10.0
        
        var offsetWidth:CGFloat = 100.0
        
        // Font settings
        let fontTitle = UIFont(name: "Helvetica Bold", size: CGFloat(self.titleFontSize))
        let fontValue = UIFont(name: "Helvetica Light", size: CGFloat(self.valueFontSize))
        
        let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Left
        let textColor = UIColor.blackColor()
        
        for storageBarValue in storageBarValues {
            var rectangle = CGRectMake(posX, posY, sizeRect, sizeRect)
            
            CGContextAddRect(context, rectangle)
            CGContextSetFillColorWithColor(context, storageBarValue.color.CGColor)
            CGContextFillRect(context, rectangle)
            
            var titleWidth = count(storageBarValue.title) * Int(titleFontSize/2)
            
            // Title drawing
            if let actualFont = fontTitle {
                let textFontAttributes = [
                    NSFontAttributeName: actualFont,
                    NSForegroundColorAttributeName: textColor,
                    NSParagraphStyleAttributeName: textStyle
                ]
            
                var titleRect = CGRectMake(posX + sizeRect + offsetToRectangle, posY, widthText, heightText)
                var titleStringToDraw:NSString = NSString(string: storageBarValue.title)
                titleStringToDraw.drawInRect(titleRect, withAttributes: textFontAttributes)
            }
        
            // Value drawing
            if let actualFont = fontValue {
                let textFontAttributes = [
                    NSFontAttributeName: actualFont,
                    NSForegroundColorAttributeName: textColor,
                    NSParagraphStyleAttributeName: textStyle
                ]
            
                var valueRect = CGRectMake(posX + sizeRect + offsetToRectangle, posY + offsetToTitle, widthText, heightText)
                var unitOfValue = self.unit ?? ""
                var valueStringToDraw:NSString = NSString(string: "\(numberFormatter.stringFromNumber(NSNumber(float:storageBarValue.value))!) \(unitOfValue)")
            
                valueStringToDraw.drawInRect(valueRect, withAttributes: textFontAttributes)
            }
            
            posX += offsetWidth
        }
    }
    
    func add(value:Float, title:String, color:UIColor) {
        storageBarValues.append(ROStorageBarValue(value: value, title: title, color: color))
        self.totalSum += value
        self.setNeedsDisplay()
    }
    
    func addStorageBarValue(storageBarValue:ROStorageBarValue) {
        storageBarValues.append(storageBarValue)
        self.totalSum += storageBarValue.value
        self.setNeedsDisplay()
    }
    
    func emptyStorageBar() {
        self.storageBarValues.removeAll(keepCapacity: false)
        totalSum = 0
    }
}


extension UIColor {
    
    convenience init(hex rgba:String) {
        
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            let index   = advance(rgba.startIndex, 1)
            let hex     = rgba.substringFromIndex(index)
            let scanner = NSScanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexLongLong(&hexValue) {
                switch (count(hex)) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
                }
            } else {
                println("Scan hex error")
            }
        } else {
            print("Invalid RGB string, missing '#' as prefix")
        }
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}