import XCTest
@testable import UDPropertyWrapper

final class UDPropertyWrapperTests: XCTestCase {

  enum Keys: String, CaseIterable {
    case userId, city, countryCode, foreignCity
  }
  struct City: Codable, Equatable {
    var name: String
  }

  struct Store {
    @UserDefault(.userId, defaultValue: "8db81829-1ecc-4d40-9d7e-9b52180acc31")
    var userId: String

    @UserDefault(.city, defaultValue: .init(name: "Tokyo"))
    var city: City

    @UserDefault(.countryCode)
    var countryCode: Int?

    @UserDefault(.foreignCity)
    var foreignCity: City?
  }
  var store = Store()

  // MARK: Override Functions

  override func setUp() {
    Keys.allCases.map(\.rawValue).forEach(UserDefaults.standard.removeObject)
    store = Store()
  }

  // MARK: Test Cases

  /// Check if `defaultValue` is correct
  func testDefaultValue() {
    XCTAssertEqual(store.userId, "8db81829-1ecc-4d40-9d7e-9b52180acc31")
    XCTAssertEqual(store.city, City(name: "Tokyo"))
    XCTAssertNil(store.countryCode)
    XCTAssertNil(store.foreignCity)
  }

  /// Check if `wrappedValue` has been mutated
  func testNonNilValue() {
    store.userId = "1234567890"
    XCTAssertEqual(store.userId, "1234567890")
    store.userId = ""
    XCTAssertEqual(store.userId, "")

    store.city = City(name: "Osaka")
    XCTAssertEqual(store.city, City(name: "Osaka"))
    store.city = City(name: "Fukuoka")
    XCTAssertEqual(store.city, City(name: "Fukuoka"))
  }

  /// Check if `wrappedValue` has been mutated
  func testNilValue() {
    store.countryCode = 81
    XCTAssertEqual(store.countryCode, 81)
    store.countryCode = nil
    XCTAssertNil(store.countryCode)
    store.countryCode = 100
    XCTAssertEqual(store.countryCode, 100)

    store.foreignCity = City(name: "Sydney")
    XCTAssertEqual(store.foreignCity, City(name: "Sydney"))
    store.foreignCity = nil
    XCTAssertNil(store.foreignCity)
    store.foreignCity = City(name: "London")
    XCTAssertEqual(store.foreignCity, City(name: "London"))
  }

  // MARK: Utilities

  static var allTests = [
    ("testDefaultValue", testDefaultValue),
    ("testNonNilValue", testNonNilValue),
    ("testNilValue", testNilValue)
  ]
}

extension UserDefault where T: Codable {
  init(_ key: UDPropertyWrapperTests.Keys, defaultValue: T) {
    self.init(key.rawValue, defaultValue: defaultValue)
  }
}

extension UserDefault where T: ExpressibleByNilLiteral {
  init(_ key: UDPropertyWrapperTests.Keys) {
    self.init(key.rawValue, defaultValue: nil)
  }
}
