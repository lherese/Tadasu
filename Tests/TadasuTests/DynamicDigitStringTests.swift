import XCTest

@testable import Tadasu

final class DynamicDigitStringTests: XCTestCase {

  struct TestDigitString: DynamicDigitString {
    let value: String

    static func count(for value: UInt64) -> Int {
      Int(value % 10)
    }
  }

  func testDynamic() {
    XCTAssertNil(TestDigitString("1233"))
    XCTAssertNotNil(TestDigitString("1234"))
    XCTAssertEqual(TestDigitString(integerLiteral: 4).description, "0004")
  }

}
