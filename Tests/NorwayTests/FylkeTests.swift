import XCTest

import Tadasu

final class FylkeTests: XCTestCase {

  func testFylkesregister() {
    XCTAssertNil(Norway.Fylke.Nummer("99"))
    XCTAssertNotNil(Norway.Fylke.Nummer("03"))
  }

  func testMedNummer() {
    XCTAssertNil(Norway.Fylke.med(nummer: "99"))
    XCTAssertNotNil(Norway.Fylke.med(nummer: "03"))
  }

  func testMedNavn() {
    XCTAssertNotNil(Norway.Fylke.med(navn: "Viken"))
    XCTAssertNil(Norway.Fylke.med(navn: "Intetfylke"))
  }

  func testEndringer2020() {
    XCTAssertEqual(Norway.Fylke.med(navn: "Viken")?.gyldig, true)
    XCTAssertEqual(Norway.Fylke.med(navn: "Akershus")?.gyldig, false)
  }

}
