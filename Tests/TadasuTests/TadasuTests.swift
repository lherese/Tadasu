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

final class MOD11Tests: XCTestCase {

  let weights = [2, 3, 4, 5, 6, 7]

  func testRoundTrip() {
    let candidate = "123456789"
    let value: String = MOD11(candidate, weights: weights)

    XCTAssertTrue(MOD11(value, weights: weights), "Calculated checksum not validated")
  }

  func testChecksum() {
    let expected = "12345678903"
    let value: String = MOD11("1234567890", weights: weights)

    XCTAssertEqual(value, expected, "Checksum miscalculated")
  }

  func testVerify() {
    XCTAssertFalse(MOD11("12345678901", weights: weights), "Simple digit mistype not caught")
    XCTAssertFalse(MOD11("12345768903", weights: weights), "Simple transposition not caught")
    XCTAssertFalse(MOD11("12365478903", weights: weights), "Complex transposition not caught")
    XCTAssertTrue(MOD11("12345678903", weights: weights), "Checksum not verified")
  }

}

final class DigitStringTests: XCTestCase {

  struct TestDigitString: DigitString {
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
