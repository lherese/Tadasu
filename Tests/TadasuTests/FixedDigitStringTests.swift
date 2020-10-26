import XCTest

@testable import Tadasu

final class FixedDigitStringTests: XCTestCase {

  struct TestDigitString: FixedDigitString {
    let value: String

    static let count = 8
  }

  let digitString: TestDigitString = 0234_5678

  func testDescription() {
    XCTAssertEqual(digitString.description, "02345678")
  }

  func testSubscripts() {
    XCTAssertEqual(digitString[1...2],  02 )
    XCTAssertEqual(digitString[1...2], "02")
    XCTAssertEqual(digitString[4],       4 )
    XCTAssertEqual(digitString[4],      "4")
  }

  func testStringConvertible() {
    XCTAssertEqual(TestDigitString(digitString.description), digitString)

    XCTAssertEqual(TestDigitString("12 34 5678"), 1234_5678)
    XCTAssertNil(TestDigitString("12 34_5678_9"))

    XCTAssertNil(TestDigitString("12 34 567a"))
    XCTAssertNil(TestDigitString("12 45_5678_a"))
  }

}
