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
    XCTAssertEqual(Norway.Fødselsnummer(integerLiteral: 220177_72175).personnummer, "72175")
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
