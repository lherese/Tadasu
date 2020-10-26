import XCTest

@testable import Tadasu

final class MOD11DigitStringTests: XCTestCase {

  struct TestDigitString: MOD11DigitString {
    let value: String

    static let count = 8
    static let weights = [ 2, 3, 4, 5, 6, 7 ]
  }

  let digitString: TestDigitString = 0234_5676

  func testDescription() {
    XCTAssertEqual(digitString.description, "02345676")
  }

  func testStringConvertible() {
    XCTAssertEqual(TestDigitString(digitString.description), digitString)

    XCTAssertNil(TestDigitString("02345678"))
  }

}
