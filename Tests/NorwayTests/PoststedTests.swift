import XCTest

import Tadasu

final class PoststedTests: XCTestCase {

  func testPostnummerRegister() {
    XCTAssertNil(Norway.Postnummer("9999"))
    XCTAssertNotNil(Norway.Postnummer("0750"))
  }

  func testMedNavn() {
    XCTAssert(Norway.Poststed.med(navn: "Oslo").count >= 1)
  }

  func testMedNummer() {
    XCTAssertNotNil(Norway.Poststed.med(nummer: "0750"))
    XCTAssertNil(Norway.Poststed.med(nummer: "9999"))
  }

  func testAssociation() {
    XCTAssertTrue(Norway.Kommune.med(navn: "Oslo")!.poststeder.contains(Norway.Poststed.med(nummer: "0750")!))
    XCTAssertEqual(Norway.Poststed.med(nummer: "0750")?.kommune.navn.contains("Oslo"), true)
  }

}
