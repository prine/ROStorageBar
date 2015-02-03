# ROStorageBar
Dynamic Storage Bar (a là iTunes Usage Bar) written in Swift

![Example](http://prine.ch//ROStorageBarExample.png "Screenshot of the ROStorageBar")

## How to use
The usage is really straighforward. Include the ROStorageBar.swift and the Helper.swift file into your project. Create a UIView in the Storyboard and set the class to ROStorageBar.

In the viewDidLoad Method you can add ROStorageBarValues with the following code:
```Swift
storageBar.addStorageBarValue(ROStorageBar.ROStorageBarValue(value: 0.4, title: "Offline Data", color: Helper.colorFromHexString("#FFABAB")))
storageBar.addStorageBarValue(ROStorageBar.ROStorageBarValue(value: 0.2, title: "Favorites", color: Helper.colorFromHexString("#FFDAAB")))
storageBar.addStorageBarValue(ROStorageBar.ROStorageBarValue(value: 0.3, title: "Test", color: Helper.colorFromHexString("#c3c3c3")))
storageBar.addStorageBarValue(ROStorageBar.ROStorageBarValue(value: 0.8, title: "Free", color: Helper.colorFromHexString("#A8DBA8")))

storageBar.unit = "GB"
storageBar.displayInfos = true // Default value would anyway be true
```

The size of the ROStorageBar is defined by the size of the UIView. Therefore also AutoLayout is perfectly working with the ROStorageBar and the adaptation and rerendering is automatically handled by the Library itself.

### Helper class
The helper is only used for easier color creation and can be easily left out. I left it in because maybe someone else can also use the hex to UIColor conversion.

Here a short example:
```Swift
var color = Helper.colorFromHexString("#A8DBA8")
```
