# UDPropertyWrapper
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

Yet another type-safed wrapper of [`UserDefaults`](https://developer.apple.com/documentation/foundation/userdefaults)

## Example
```swift
struct UserDefaultsStore {
  @UserDefault("age", defaultValue: 0)
  var age: Int
  
  // If you don't assign any value to `defaultValue`, `nil` will be inserted automatically.
  @UserDefault("lastName")
  var lastName: String?
}
```

Since  `UDPropertyWrapper` is type-safed, you cannot assign a value to `defaultValue` ignoring the type associted to the property.
```swift
// ⛔️ Cannot convert value of type 'String' to expected argument type 'Int'
@UserDefault("age", defaultValue: "")
var age: Int

// ⛔️ 'nil' is not compatible with expected argument type 'Int'
@UserDefault("age", defaultValue: nil)
var age: Int

// ⛔️ Referencing initializer 'init(_:)' on 'UserDefault' requires that 'String' conform to ExpressibleByNilLiteral'
@UserDefault("lastName")
var lastName: String
```

Introducing some small extensions on `UserDefault` enables you to bind enumeration cases.
```swift
enum UDKeys: String {
  case userId, countryCode
}

extension UserDefault where T: Codable {
  init(_ key: UDKeys, defaultValue: T) {
    self.init(key.rawValue, defaultValue: defaultValue)
  }
}

extension UserDefault where T: ExpressibleByNilLiteral {
  init(_ key: UDKeys) {
    self.init(key.rawValue, defaultValue: nil)
  }
}

// ✨ Great!
@UserDefault(.userId)
var userId: String

// ✨ Awesome!
@UserDefault(.countryCode)
var countryCode: Int?
```

## Requirements
- Swift 5.3+
- Xcode12.0+

## Installations
### CocoaPods
```ruby
pod 'UDPropertyWrapper'
````

### Swift Package Manager
- Select File > Swift Packages > Add Package Dependency....
- Enter https://github.com/struuuuggle/UDPropertyWrapper in the "Choose Package Repository" dialog.
- Specify a rule as Branch, and set the branch field to `main`.
