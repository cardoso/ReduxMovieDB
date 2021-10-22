# CombineKeyboard

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)

CombineKeyboard is a way to getting keyboard frame or height with Combine, inspired by the RxSwift Community's [RxKeyboard](https://github.com/RxSwiftCommunity/RxKeyboard) library.

## Usage

CombineKeyboard provides three `Publisher`s. (If you want more Publisher, you can contributes this library)

```swift
/// A publisher emitting current keyboard `frame`
/// You will be returned the current keyboard `frame` at start of subscription.
public var frame: AnyPublisher<CGRect, Never>

/// A publisher emitting current keyboard `height`
/// You will be returned the current keyboard `height` at start of subscription.
public var height: AnyPublisher<CGFloat, Never>
    
/// A publisher emitting current keyboard `height` when keyboard's height is updated
public var heightUpdated: AnyPublisher<CGFloat, Never>
```

You can use three `Publisher`s with `CombineKeyboard.shared`

```swift
CombineKeyboard.shared.frame
  .sink(receiveValue: { frame: CGRect in
    print(frame) 
  })
  .store(in: &cancellables)

CombineKeyboard.shared.height
  .sink(receiveValue: { currentHeight: CGFloat in
    print(currentHeight) 
  })
  .store(in: &cancellables)
  
CombineKeyboard.shared.heightUpdated
  .sink(receiveValue: { height: CGFloat in
    print(height) 
  })
  .store(in: &cancellables)
```

## Requirements

- Swift 5
- iOS 13 +

## Installation

CombineKeyboard is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CombineKeyboard'
```

## License

CombineKeyboard is available under the MIT license. See the LICENSE file for more info.

---

This Library was made inspired by [RxKeyboard](https://github.com/RxSwiftCommunity/RxKeyboard) library. thanks to [RxKeyboard's Contributers](https://github.com/RxSwiftCommunity/RxKeyboard/graphs/contributors)
