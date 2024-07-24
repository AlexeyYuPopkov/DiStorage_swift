# DiStorage

[![CI Status](https://img.shields.io/travis/8243302/DiStorage.svg?style=flat)](https://travis-ci.org/8243302/DiStorage)
[![Version](https://img.shields.io/cocoapods/v/DiStorage.svg?style=flat)](https://cocoapods.org/pods/DiStorage)
[![License](https://img.shields.io/cocoapods/l/DiStorage.svg?style=flat)](https://cocoapods.org/pods/DiStorage)
[![Platform](https://img.shields.io/cocoapods/p/DiStorage.svg?style=flat)](https://cocoapods.org/pods/DiStorage)


**DiStorage** is a lightweight dependency injection library for `swift`.
The main advantage is the small amount of code (something like 200 lines).
Therefore, you can look at code and be sure that the program does not contain any back doors and so on.
Also, the library demonstrates what dependency injection is and how similar libraries work.
The latter is important for beginning developers.

## Limitation
Do not working with `struct` yet

## Usage
### Without scopes
```swift
import DiStorage

DiStorage.shared.bind(
    interface: DoSomethingRepository.self,
    lifeTime: .prototype,
    scope: nil,
    constructor: {
        return DoSomethingElseRepositoryImpl()
    }
)

// ....

// Using `DoSomethingRepository`
let doSomethingRepository: DoSomethingRepository = DiStorage.shared.resolve()

// ....

// Optionally you can remove binding
  DiStorage.shared.remove(DoSomethingRepository.self)

```

### With scopes
```swift
import DiStorage

final class SomeDiScope: DiScope {
    func bind(di: DiStorage) {

        di.bind(
            interface: DoSomethingRepository.self,
            lifeTime: .weakSingle,
            tag: self
        ) {
            DoSomethingRepositoryImpl()
        }

        di.bind(
            interface: DoSomethingElseRepository.self,
            lifeTime: .prototype,
            tag: self
        ) {
            DoSomethingElseRepositoryImpl()
        }
    }
}

...

// create binding 
SomeDiScope().bind(di: DiStorage.shared)

...

// Using `DoSomethingRepository`
let doSomethingRepository: DoSomethingRepository = DiStorage.shared.resolve()
let doSomethingElseRepository: DoSomethingElseRepository = DiStorage.shared.resolve()

...

// Optionally you can remove binding of scope
DiStorage.shared.remove(scope: SomeDiScope.self)
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
Entry point, describing the DiStorage is `RootRouter.swift` 

## Requirements

## Installation

### Cocoapods

DiStorage is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DiStorage'
```

### Swift Package Manager

You can add `DiStorage` to your project using [Swift Package Manager](https://swift.org/package-manager/).

1. Open your project in Xcode.
2. Navigate to `File > Add Packages...`.
3. In the search bar, enter the URL of the `DiStorage` repository: https://github.com/AlexeyYuPopkov/DiStorage_swift.git
4. Specify the version, branch, or commit you want to use. It's recommended to use a version range:
5. Click `Add Package`.

## Author

Alekseii Popkov, alexey.yu.popkov@gmail.com

## License

DiStorage is available under the MIT license. See the LICENSE file for more info.
