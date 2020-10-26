import XCTest

@testable import Tadasu

final class PaddingTests: XCTestCase {

  func testLeftPad() {
    let expected = "000123"
    let value = "123".padding(toLength: 6, withString: "0")

    XCTAssertEqual(value, expected)
  }

  func testLeftTrim() {
    let expected = "23"
    let value = "123".padding(toLength: 2, withString: "0")

    XCTAssertEqual(value, expected)
  }

  func testLeftFill() {
    let expected = "101123"
    let value = "123".padding(toLength: 6, withString: "10")

    XCTAssertEqual(value, expected)
  }

}
