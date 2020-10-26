import XCTest

import Tadasu

final class FødselsnummerTests: XCTestCase {

  func testIntegerLiteral() {
    let fnummer: Norway.Fødselsnummer = 100201_30828

    XCTAssertEqual(fnummer.description, "100201 30828")
  }

  func testNumberNormalisation() {
    let fnummer = Norway.Fødselsnummer("１００２０１　３０８２８")

    XCTAssertNotNil(fnummer)
    XCTAssertEqual(fnummer?.description, "100201 30828")
  }

  func testValidation() {
    XCTAssertNil(Norway.Fødselsnummer("100201 30829"), "Simple digit mistype not caught")
    XCTAssertNil(Norway.Fødselsnummer("102001 30828"), "Simple transposition not caught")
    XCTAssertNil(Norway.Fødselsnummer("100102 30828"), "Complex transposition not caught")
    XCTAssertNotNil(Norway.Fødselsnummer("100201 30828"), "Valid number rejected")
  }

  func testLetters() {
    XCTAssertNil(Norway.Fødselsnummer("100201 3082a"))
  }

  func testKjønn() {
    XCTAssertEqual(Norway.Fødselsnummer(integerLiteral: 220177_72175).kjønn,   .mann)
    XCTAssertEqual(Norway.Fødselsnummer(integerLiteral: 091003_27209).kjønn, .kvinne)
    XCTAssertEqual(Norway.Fødselsnummer(integerLiteral: 080474_29391).kjønn,   .mann)
    XCTAssertEqual(Norway.Fødselsnummer(integerLiteral: 050468_62483).kjønn, .kvinne)
    XCTAssertEqual(Norway.Fødselsnummer(integerLiteral: 281172_65813).kjønn, .kvinne)
    XCTAssertEqual(Norway.Fødselsnummer(integerLiteral: 230197_64966).kjønn,   .mann)
  }

  func testRegistertype() {
    XCTAssertEqual(Norway.Fødselsnummer(integerLiteral: 220177_72175).registertype, .fødselsnummer)
    XCTAssertEqual(Norway.Fødselsnummer(integerLiteral: 420177_22284).registertype,      .D_nummer)
    XCTAssertEqual(Norway.Fødselsnummer(integerLiteral: 224177_72158).registertype,      .H_nummer)
    XCTAssertEqual(Norway.Fødselsnummer(integerLiteral: 987654_32103).registertype,     .FH_nummer)
  }

  func testSerie() {
    XCTAssertEqual(Norway.Fødselsnummer(integerLiteral: 220177_72175).serie, .fra1854)
    XCTAssertNil(Norway.Fødselsnummer(integerLiteral: 224177_72158).serie)
  }

  func testPersonnummer() {
    XCTAssertEqual(Norway.Fødselsnummer(integerLiteral: 220177_72175).personnummer, 721)
  }

  func testDate() {
    XCTAssertEqual(Norway.Fødselsnummer(integerLiteral: 220177_72175).fødselsdato, "1877-01-22")
    XCTAssertEqual(Norway.Fødselsnummer(integerLiteral: 420177_22284).fødselsdato, "1977-01-02")
    XCTAssertEqual(Norway.Fødselsnummer(integerLiteral: 520914_23480).fødselsdato, "2014-09-12")
    XCTAssertEqual(Norway.Fødselsnummer(integerLiteral: 224177_72158).fødselsdato, "1977-01-22")
    XCTAssertNil(Norway.Fødselsnummer(integerLiteral: 987654_32103).fødselsdato)
  }

  func testFH_nummer() {
    for _ in 1...1000 {
      let fnummer = Norway.Fødselsnummer()

      XCTAssertNil(fnummer.serie)
      XCTAssertNil(fnummer.fødselsdato)
      XCTAssertEqual(fnummer.registertype, .FH_nummer)
    }
  }

}

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
