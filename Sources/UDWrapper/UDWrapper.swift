import Foundation

/// Type-safed wrapper of `UserDeafults`
///
/// Usage:
///
///  ```
///  class UserDefaultsStore {
///    @UserDefault("age", defaultValue: 0)
///    var age: Int
///
///    // Cannot convert value of type 'String' to expected argument type 'Int'
///    // @UserDefault("age", defaultValue: "")
///    // var age: Int
///
///    // 'nil' is not compatible with expected argument type 'Int'
///    // @UserDefault("age", defaultValue: nil)
///    // var age: Int
///
///    @UserDefault("lastName")
///    var lastName: String?
///
///    // Referencing initializer 'init(_:)' on 'UserDefault' requires that 'String' conform to ExpressibleByNilLiteral'
///    // @UserDefault("lastName")
///    // var lastName: String
///  }
/// ```
/// You can also define properties with custom types you created.
/// ```
/// struct City: Codable {
///   var name: String
/// }
/// class UserDefaultsStore {
///   @UserDeafult("city")
///   var city: City?
/// }
/// ```
@propertyWrapper
public struct UserDefault<T: Codable> {
  /// The key passed to the argument of `UserDefaults#object(forKey:)`
  let key: String
  /// The value which is returned when UserDefaults didn't contain any value associated to the `key`
  let defaultValue: T
  private let store: UserDefaults = .standard

  init(_ key: String, defaultValue: T) {
    self.key = key
    self.defaultValue = defaultValue
  }

  public var wrappedValue: T {
    get {
      guard let object = store.object(forKey: key) as? Data,
            let value = try? JSONDecoder().decode(T.self, from: object) else {
        return defaultValue
      }
      return value
    }
    set {
      guard let data = try? JSONEncoder().encode(newValue) else { return }
      store.set(data, forKey: key)
    }
  }
}

public extension UserDefault where T: ExpressibleByNilLiteral {
  init(_ key: String) {
    self.init(key, defaultValue: nil)
  }
}
