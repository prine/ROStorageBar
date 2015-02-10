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
```

The size of the ROStorageBar is defined by the size of the UIView. Therefore also AutoLayout is perfectly working with the ROStorageBar and the adaptation and rerendering is automatically handled by the Library itself. If you have set the displayCaptions to true it does automatically split the view in half. It uses the upper half for the bar and the lower bar for the captions. If there aren't any captions it takes the full height of the UIView.

### Helper class
The helper is only used for easier color creation and can be easily left out. I left it in because maybe someone else can also use the hex to UIColor conversion.

Here a short example:
```Swift
var color = Helper.colorFromHexString("#A8DBA8")
```
