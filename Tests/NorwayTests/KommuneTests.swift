import XCTest

import Tadasu

final class KommuneTests: XCTestCase {

  func testKommuneregister() {
    XCTAssertNil(Norway.Kommune.Nummer("9999"))
    XCTAssertNotNil(Norway.Kommune.Nummer("3012"))
  }

  func testMedNummer() {
    XCTAssertNil(Norway.Kommune.med(nummer: "9999"))
    XCTAssertNotNil(Norway.Kommune.med(nummer: "3012"))
  }

  func testMedNavn() {
    XCTAssertNotNil(Norway.Kommune.med(navn: "Ås"))
    XCTAssertNil(Norway.Kommune.med(navn: "Ikkekommune"))
  }

}
