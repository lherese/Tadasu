import XCTest

@testable import Tadasu

final class DigitStringTests: XCTestCase {

  struct TestDigitString: DigitString {
    let value: String
  }

  let digitString: TestDigitString = 0234_5678

  func testDescription() {
    XCTAssertEqual(digitString.description, "2345678")
  }

  func testSubscripts() {
    XCTAssertEqual(digitString[1...2],  23 )
    XCTAssertEqual(digitString[1...2], "23")
    XCTAssertEqual(digitString[4],       5 )
    XCTAssertEqual(digitString[4],      "5")
  }

  func testStringConvertible() {
    XCTAssertEqual(TestDigitString(digitString.description), digitString)

    XCTAssertEqual(TestDigitString("12 34 5678"), 1234_5678)
    XCTAssertEqual(TestDigitString("12 34_5678_9"), 123456789)

    XCTAssertNil(TestDigitString("12 34 567a"))
    XCTAssertNil(TestDigitString("12 45_5678_a"))
  }

}
