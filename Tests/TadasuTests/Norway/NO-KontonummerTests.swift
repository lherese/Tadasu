import XCTest

import Tadasu

final class KontonummerTests: XCTestCase {

  func testIntegerLiteral() {
    let kontonr: Norway.Kontonummer = 0100_55_00008

    XCTAssertEqual(kontonr.description, "0100.55.00008")
  }

  func testNumberNormalisation() {
    let kontonr = Norway.Kontonummer("０１００　５５　００００8")

    XCTAssertNotNil(kontonr)
    XCTAssertEqual(kontonr?.description, "0100.55.00008")
  }

  func testValidation() {
    XCTAssertNil(Norway.Kontonummer("0200.55.00008"), "Simple digit mistype not caught")
    XCTAssertNil(Norway.Kontonummer("0010.55.00008"), "Simple transposition not caught")
    XCTAssertNil(Norway.Kontonummer("0001.55.00008"), "Complex transposition not caught")
    XCTAssertNotNil(Norway.Kontonummer("0100.55.00008"), "Valid number rejected")
  }

  func testLetters() {
    XCTAssertNil(Norway.Kontonummer("0100.55.0000a"))
  }

  func testCheckdash() {
    XCTAssertNil(Norway.Kontonummer("0100.55.0013-"))
  }

  func testComponents() {
    let kontonr: Norway.Kontonummer = 0100_55_00008

    XCTAssertEqual(kontonr.bankregisternummer, "0100")
    XCTAssertEqual(kontonr.kontogruppe,          "55")
    XCTAssertEqual(kontonr.kundekontonummer,   "0000")
  }

  func testNext() {
    let earlyKontonr: Norway.Kontonummer = 0100_55_00008

    XCTAssertEqual(earlyKontonr.neste, 0100_55_00016)

    let lateKontonr: Norway.Kontonummer = 0100_55_99993

    XCTAssertNil(lateKontonr.neste)
  }

  func testComponentInitialisation() {
    XCTAssertEqual(Norway.Kontonummer(bankregisternummer: 0100, kontogruppe: 55, kundekontonummer: 0000), 0100_55_00008)
    XCTAssertNil(Norway.Kontonummer(bankregisternummer: 0100, kontogruppe: 55, kundekontonummer: 0013))
  }

}
