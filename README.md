# ReduxMovieDB
[![Build Status](https://travis-ci.org/cardoso/ReduxMovieDB.svg?branch=master)](https://travis-ci.org/cardoso/ReduxMovieDB)

## Screenshots
|iPhone (1)|iPhone (2)|iPad|
|----------|----------|----|
|![](screenshots/screen_iphone_1.png)|![](screenshots/screen_iphone_2.png)|![](screenshots/screen_ipad_1.png)|

## Dependencies
|#|Library|Description|
|-|-|-|
|1|[ReSwift](https://github.com/ReSwift/ReSwift)|Redux-like implementation of the unidirectional data flow architecture.|
|2|[RxSwift](https://github.com/ReactiveX/RxSwift)|For composing asynchronous and event-based Apps using observable sequences.|
|3|[RxKeyboard](https://github.com/RxSwiftCommunity/RxKeyboard)|Provides a reactive way of observing keyboard frame changes.|
|4|[Nuke](https://github.com/kean/Nuke)|Provides an async image downloader with cache support.|
|5|[DifferenceKit](https://github.com/ra1028/DifferenceKit)|A fast and flexible O(n) difference algorithm framework for Swift collection.|

## Build instructions

1. An OSX machine
2. Xcode 10.x or higher (Swift 4.2)
3. Install [CocoaPods](https://cocoapods.org/) (note that you will need to install at least Ruby 2.2.3 for this to work)
```
sudo gem install cocoapods
```
To update cocoapods (not that often needed) run
```
sudo gem update cocoapods
```
4. Clone this repo:
```
git clone https://github.com/cardoso/ReduxMovieDB
```
5. Download library dependencies using the cocoapods dependency manager (and update the same way):
```
pod install
```
6. Do NOT open the Xcode project directly, instead use the ReduxMovieDB.xcworkspace file to open the Xcode workspace.
7. Build the project by ⌘ + R
