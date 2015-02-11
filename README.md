# ROStorageBar
Dynamic Storage Bar (a là iTunes Usage Bar) written in Swift

![Example](http://prine.ch//ROStorageBar.png "Screenshot of the ROStorageBar")

It is also possible to add captions underneath the bar.

![ExampleWithCaptions](http://prine.ch//ROStorageBar_caption.png "Screenshot of the ROStorageBar with Captions")

## How to use
The usage is really straighforward. Include the ROStorageBar.swift and the Helper.swift file into your project. Create a UIView in the Storyboard and set the class to ROStorageBar.

In the viewDidLoad Method you can add ROStorageBarValues with the following code:
```Swift
    override func viewDidLoad() {
        super.viewDidLoad()

        storageBar.add(0.2, title: "Apps", color: UIColor(hex:"#FFABAB"))
        storageBar.add(0.15, title: "Documents", color: UIColor(hex:"#FFD29B"))
        storageBar.add(0.21, title: "Photos", color: UIColor(hex:"#DDEBF9"))
        storageBar.add(0.3, title: "Movies", color: UIColor(hex:"#c3c3c3"))
        
        // Or if you want to use directly the struct to add an item
        storageBar.addStorageBarValue(ROStorageBarValue(value: 0.6, title: "Backups", color: UIColor(hex:"#A8DBA8")))
        
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
```

The size of the ROStorageBar is defined by the size of the UIView. Therefore also AutoLayout is perfectly working with the ROStorageBar and the adaptation and rerendering is automatically handled by the Library itself. If you have set the displayCaptions to true it does automatically split the view in half. It uses the upper half for the bar and the lower bar for the captions. If there aren't any captions it takes the full height of the UIView.

### UIColor Extension
The extension is only used for easier color creation and can be easily left out. I left it in because maybe someone else can also use the hex to UIColor conversion.

Here a short example:
```Swift
var color = UIColor(hex:"#A8DBA8")
```

## License

```
The MIT License (MIT)

Copyright (c) 2015 Robin Oster (http://prine.ch)

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
