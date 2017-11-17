//
//  ROStorageBar.swift
//
// The MIT License (MIT)
//
// Copyright (c) 2016 Robin Oster (http://prine.ch)
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
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


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

open class ROStorageBar : UIView {
    
    fileprivate var storageBarValues = [ROStorageBarValue]()
    fileprivate var totalSum:Float = 0.0
    fileprivate var height:CGFloat!
    
    open var borderWidth:Float = 1.0
    open var borderColor:UIColor = UIColor.darkGray
    open var titleFontSize = 10.0
    open var valueFontSize = 10.0
    open var displayTitle:Bool = true
    open var displayValue:Bool = true
    open var displayCaption:Bool = false
    open var numberFormatter:NumberFormatter
    open var unit:String?
    
    public init() {
        // Initilaize the default number formatter
        numberFormatter = NumberFormatter()
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.maximumFractionDigits = 1
        
        super.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        // Initilaize the default number formatter
        numberFormatter = NumberFormatter()
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.maximumFractionDigits = 1
        
        super.init(coder:aDecoder)
    }
    
    override open  func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        // Depending if the captions should be drawn or not set a different height
        height = displayCaption ? frame.height/2 : frame.height
        
        drawStorageRects(context!)
        
        if displayCaption {
            drawCaption(context!)
        }
    }
    
    func drawStorageRects(_ context:CGContext) {
        
        context.setLineWidth(CGFloat(borderWidth))
        
        var currentX:Float = borderWidth
        let scale = (Float(self.frame.width) - 2 * borderWidth) / totalSum
        
        for storageBarValue in storageBarValues {
            let color = storageBarValue.color.cgColor
            
            let height:CGFloat = self.height - 2 * CGFloat(borderWidth)
            let rectangle = CGRect(x: CGFloat(currentX), y: CGFloat(borderWidth), width: CGFloat(storageBarValue.value * scale),height: height)
            
            context.setStrokeColor(borderColor.cgColor)
            context.addRect(rectangle)
            context.strokePath()
            context.setFillColor(color)
            context.fill(rectangle)
            
            currentX += (storageBarValue.value * scale)
            
            self.drawString(storageBarValue, rect: rectangle)
        }
    }
    
    func drawString(_ storageBarValue:ROStorageBarValue, rect:CGRect) {
        
        let fontTitle = UIFont(name: "Helvetica Bold", size: CGFloat(self.titleFontSize))
        let fontValue = UIFont(name: "Helvetica Light", size: CGFloat(self.valueFontSize))
        
        let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.center
        let textColor = UIColor.black
        
        var amountOfLineBreaks:Int?
        
        if displayTitle {
            if let actualFont = fontTitle {
                let textFontAttributes = [
                    NSFontAttributeName: actualFont,
                    NSForegroundColorAttributeName: textColor,
                    NSParagraphStyleAttributeName: textStyle
                ]
                
                let titleStringToDraw:NSString = NSString(string: storageBarValue.title)
                let positionedTitleRect = CGRect(x: rect.origin.x, y: rect.origin.y + (self.height/2 - CGFloat(titleFontSize)), width: rect.width, height: rect.height)
                
                let titleWidth = storageBarValue.title.count * (Int(titleFontSize/2)+1)
                
                amountOfLineBreaks = Int(ceil(Float(titleWidth) / Float(rect.width)))
                
                // Only display the title if there are less than 4 line breaks
                if amountOfLineBreaks < 4 {
                    titleStringToDraw.draw(in: positionedTitleRect, withAttributes: textFontAttributes)
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
                let valueStringToDraw:NSString = NSString(string: "\(numberFormatter.string(from: NSNumber(value: storageBarValue.value as Float))!) \(unitOfValue)")
                let positionedValueRect = CGRect(x: rect.origin.x, y: rect.origin.y + calculatedOffsetY, width: rect.width, height: rect.height)
                
                if lineBreaks < 4 {
                    valueStringToDraw.draw(in: positionedValueRect, withAttributes: textFontAttributes)
                }
            }
        }
    }
    
    func drawCaption(_ context:CGContext) {
        
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
        
        let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.left
        let textColor = UIColor.black
        
        for storageBarValue in storageBarValues {
            let rectangle = CGRect(x: posX, y: posY, width: sizeRect, height: sizeRect)
            
            context.addRect(rectangle)
            context.setFillColor(storageBarValue.color.cgColor)
            context.fill(rectangle)
            
            // Title drawing
            if let actualFont = fontTitle {
                let textFontAttributes = [
                    NSFontAttributeName: actualFont,
                    NSForegroundColorAttributeName: textColor,
                    NSParagraphStyleAttributeName: textStyle
                ]
                
                let titleRect = CGRect(x: posX + sizeRect + offsetToRectangle, y: posY, width: widthText, height: heightText)
                let titleStringToDraw:NSString = NSString(string: storageBarValue.title)
                titleStringToDraw.draw(in: titleRect, withAttributes: textFontAttributes)
            }
            
            // Value drawing
            if let actualFont = fontValue {
                let textFontAttributes = [
                    NSFontAttributeName: actualFont,
                    NSForegroundColorAttributeName: textColor,
                    NSParagraphStyleAttributeName: textStyle
                ]
                
                let valueRect = CGRect(x: posX + sizeRect + offsetToRectangle, y: posY + offsetToTitle, width: widthText, height: heightText)
                let unitOfValue = self.unit ?? ""
                let valueStringToDraw:NSString = NSString(string: "\(numberFormatter.string(from: NSNumber(value: storageBarValue.value as Float))!) \(unitOfValue)")
                
                valueStringToDraw.draw(in: valueRect, withAttributes: textFontAttributes)
            }
            
            posX += offsetWidth
        }
    }
    
    open func add(_ value:Float, title:String, color:UIColor) {
        storageBarValues.append(ROStorageBarValue(value: value, title: title, color: color))
        self.totalSum += value
        self.setNeedsDisplay()
    }
    
    open func addStorageBarValue(_ storageBarValue:ROStorageBarValue) {
        storageBarValues.append(storageBarValue)
        self.totalSum += storageBarValue.value
        self.setNeedsDisplay()
    }
    
    open func emptyStorageBar() {
        self.storageBarValues.removeAll(keepingCapacity: false)
        totalSum = 0
    }
}
