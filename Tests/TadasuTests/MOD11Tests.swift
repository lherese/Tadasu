import XCTest

@testable import Tadasu

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
