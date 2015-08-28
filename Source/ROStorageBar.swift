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

public struct ROStorageBarValue {
    public var value:Float
    public var title:String
    public var color:UIColor
    
    public init(value:Float, title:String, color:UIColor) {
        self.value = value
        self.title = title
        self.color = color
    }
}

public class ROStorageBar : UIView {
    
    private var storageBarValues = [ROStorageBarValue]()
    private var totalSum:Float = 0.0
    private var height:CGFloat!
    
    public var borderWidth:Float = 1.0
    public var borderColor:UIColor = UIColor.darkGrayColor()
    public var titleFontSize = 10.0
    public var valueFontSize = 10.0
    public var displayTitle:Bool = true
    public var displayValue:Bool = true
    public var displayCaption:Bool = false
    public var numberFormatter:NSNumberFormatter
    public var unit:String?
    
    public init() {
        // Initilaize the default number formatter
        numberFormatter = NSNumberFormatter()
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.maximumFractionDigits = 1
        
        // TODO: Check if this is a correct solution
        super.init(frame: CGRectZero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        // Initilaize the default number formatter
        numberFormatter = NSNumberFormatter()
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.maximumFractionDigits = 1
        
        super.init(coder:aDecoder)
    }
    
    override public  func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        // Depending if the captions should be drawn or not set a different height
        height = displayCaption ? frame.height/2 : frame.height
        
        drawStorageRects(context!)
        
        if displayCaption {
            drawCaption(context!)
        }
    }
    
    func drawStorageRects(context:CGContext) {
        
        CGContextSetLineWidth(context, CGFloat(borderWidth))
        
        var currentX:Float = borderWidth
        let scale = (Float(self.frame.width) - 2 * borderWidth) / totalSum
        
        for storageBarValue in storageBarValues {
            let color = storageBarValue.color.CGColor
            
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
                
                let titleStringToDraw:NSString = NSString(string: storageBarValue.title)
                let positionedTitleRect = CGRectMake(rect.origin.x, rect.origin.y + (self.height/2 - CGFloat(titleFontSize)), rect.width, rect.height)
                
                let titleWidth = storageBarValue.title.characters.count * (Int(titleFontSize/2)+1)
                
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
                let lineBreaks = amountOfLineBreaks ?? ((displayTitle) ? 2 : 0)
                let titleValuePadding = 2.0
                
                // Depending on the amount of line breaks the title has we need to calculate an offset for the y position
                let calculatedOffsetY = (self.height/2 - CGFloat(titleFontSize) + (CGFloat(lineBreaks) * CGFloat(titleFontSize + titleValuePadding)))
                
                // Display the unit if its given
                let unitOfValue = self.unit ?? ""
                let valueStringToDraw:NSString = NSString(string: "\(numberFormatter.stringFromNumber(NSNumber(float:storageBarValue.value))!) \(unitOfValue)")
                let positionedValueRect = CGRectMake(rect.origin.x, rect.origin.y + calculatedOffsetY, rect.width, rect.height)
                
                if lineBreaks < 4 {
                    valueStringToDraw.drawInRect(positionedValueRect, withAttributes: textFontAttributes)
                }
            }
        }
    }
    
    func drawCaption(context:CGContext) {
        
        let offsetToBar:CGFloat = 10.0
        let offsetToRectangle:CGFloat = 5.0
        let offsetToTitle:CGFloat = 13.0
        let widthText:CGFloat = 80.0
        let heightText:CGFloat = 15.0
        var posX:CGFloat = 0.0
        let posY:CGFloat = self.height + offsetToBar
        let sizeRect:CGFloat = 10.0
        
        let offsetWidth:CGFloat = 100.0
        
        // Font settings
        let fontTitle = UIFont(name: "Helvetica Bold", size: CGFloat(self.titleFontSize))
        let fontValue = UIFont(name: "Helvetica Light", size: CGFloat(self.valueFontSize))
        
        let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Left
        let textColor = UIColor.blackColor()
        
        for storageBarValue in storageBarValues {
            let rectangle = CGRectMake(posX, posY, sizeRect, sizeRect)
            
            CGContextAddRect(context, rectangle)
            CGContextSetFillColorWithColor(context, storageBarValue.color.CGColor)
            CGContextFillRect(context, rectangle)
            
            // Title drawing
            if let actualFont = fontTitle {
                let textFontAttributes = [
                    NSFontAttributeName: actualFont,
                    NSForegroundColorAttributeName: textColor,
                    NSParagraphStyleAttributeName: textStyle
                ]
                
                let titleRect = CGRectMake(posX + sizeRect + offsetToRectangle, posY, widthText, heightText)
                let titleStringToDraw:NSString = NSString(string: storageBarValue.title)
                titleStringToDraw.drawInRect(titleRect, withAttributes: textFontAttributes)
            }
            
            // Value drawing
            if let actualFont = fontValue {
                let textFontAttributes = [
                    NSFontAttributeName: actualFont,
                    NSForegroundColorAttributeName: textColor,
                    NSParagraphStyleAttributeName: textStyle
                ]
                
                let valueRect = CGRectMake(posX + sizeRect + offsetToRectangle, posY + offsetToTitle, widthText, heightText)
                let unitOfValue = self.unit ?? ""
                let valueStringToDraw:NSString = NSString(string: "\(numberFormatter.stringFromNumber(NSNumber(float:storageBarValue.value))!) \(unitOfValue)")
                
                valueStringToDraw.drawInRect(valueRect, withAttributes: textFontAttributes)
            }
            
            posX += offsetWidth
        }
    }
    
    public func add(value:Float, title:String, color:UIColor) {
        storageBarValues.append(ROStorageBarValue(value: value, title: title, color: color))
        self.totalSum += value
        self.setNeedsDisplay()
    }
    
    public func addStorageBarValue(storageBarValue:ROStorageBarValue) {
        storageBarValues.append(storageBarValue)
        self.totalSum += storageBarValue.value
        self.setNeedsDisplay()
    }
    
    public func emptyStorageBar() {
        self.storageBarValues.removeAll(keepCapacity: false)
        totalSum = 0
    }
}