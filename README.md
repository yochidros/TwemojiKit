# TwemojiKit
[license](https://img.shields.io/badge/license-MIT-green)
[
TwemojiKit is simple library that provide [Twemoji](https://github.com/twitter/twemoji) image URL, using twemoji core library.

# What is it ?
TwemojiKit is wrapper class for twemoji library. It can parse iOS emoji to twemoji. 

<img src="https://github.com/yochidros/TwemojiKit/blob/master/Screenshots/preview.png" width="320" height="580">

# Requirements
TwemojiKit requires iOS 11.0 or above, and swift 5.


# Installation
  - Add sources files to your project.
  - ### [CocoaPods](https://cocoapods.org/)
    ```ruby  
    pod 'TwemojiKit'
    ```
  - ### [Carthage](https://github.com/Carthage/Carthage)
    ```
    github "yochidros/TwemojiKit"
    ```


# Usage 
Simple Example.

 emoji = "✌️"
```swift
 let twemoji = Twemoji.shared.parse(emoji)
 ```
its return `[TwemojiImage`]
```swift[
[
 TwemojiImage(
    - base : "✌️"
    - size : TwemojiKit.TwemojiSize.x72
    - code : "270c"
    - ext : ".png"
 )
]
```
Normal Text With,

text = "Hello, 🐶"
```swift
  let withText = Twemoji.shared.parse(text)
```

return
```
[
 TwemojiImage(
  - base : "🐶"
    - size : TwemojiKit.TwemojiSize.x72
    - code : "1f436"
    - ext : ".png"
 )
```

Mutli Emojis Example,

```swift
 let emojis = "🐱 and 🐶"
```

return
```
[
  0 : TwemojiImage
    - base : "🐱"
    - size : TwemojiKit.TwemojiSize.x72
    - code : "1f431"
    - ext : ".png"
  1 : TwemojiImage
    - base : "🐶"
    - size : TwemojiKit.TwemojiSize.x72
    - code : "1f436"
    - ext : ".png"
]
   ``````
### Options

 - If want to use as UILabel attributedText.
```swift
  let attrStr = Twemoji.shared.parseAttributeString("💪 muscle")
  label.attributedText = attrStr
```

 - Image Only
```swift
guard let firstImage = Twemoji.shared.parse("🐶").first else { return }
imageView.image = Twemoji.shared.convertImage(twemoji: firstImage)
```

# Dependencies 
 - Twemoji [https://github.com/twitter/twemoji](https://github.com/twitter/twemoji)
# Author 
yochidros, mm9.movement.trb@gmail.com

# License
TwemojiKit is available under the MIT license. See the LICENSE file for more info.
