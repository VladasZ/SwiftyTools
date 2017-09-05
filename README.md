# SwiftyTools

![CocoaPods](https://img.shields.io/cocoapods/p/AFNetworking.svg)
[![CocoaPods](https://img.shields.io/badge/pod-0.9.2-blue.svg)](https://github.com/VladasZ/SwiftyTools)
![CocoaPods](https://img.shields.io/badge/status-alpha-orange.svg)
[![CocoaPods](https://img.shields.io/badge/swift-3.1-brightgreen.svg)](https://swift.org)
[![CocoaPods](https://img.shields.io/badge/license-MIT-lightgray.svg)](https://github.com/VladasZ/SwiftyTools/blob/master/LICENSE)


## Swift tools kit to make your life easier.

### Log with miltiply levels and automatic location:

```swift
  Log.info()
  Log.warning()
  Log.error()
  Log.info("Hello world")
```
#### Result:

![](http://i.imgur.com/Uf9aiWA.png)

### Optional String isEmpty property:

```swift
  let string1: String? = nil
  let string2: String? = ""
  let string3: String? = "Hello"
        
  print(string1.isEmpty)
  print(string2.isEmpty)
  print(string3.isEmpty)
```
#### Result:

  true
  
  true
  
  false
  

## Array tools.

### unique property:

```swift
  let arr = [2, 2, 2, 2, 2, 2, 3, 1, 1]
  print(arr.unique)
```

#### Result:

  [2, 3, 1]

### Random functions:

```swift
  var arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
        
  let random = arr.randomElement
  let randomFive = arr.random(5)
  let popped = arr.popRandom()
        
  print("Random: \(random)")
  print("Random five: \(randomFive)")
  print("Popped: \(popped)")
  print("Array: \(arr)")
```
#### Result:

Random: 0

Random five: [3, 2, 9, 1, 6]

Popped: 5

Array: [1, 2, 3, 4, 6, 7, 8, 9, 0]
