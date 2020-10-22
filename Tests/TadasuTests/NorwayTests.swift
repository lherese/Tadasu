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
    let fnummer = Norway.Fødselsnummer("100201 3082a")

    XCTAssertNil(fnummer)
  }

  func testKjønn() {
    XCTAssertEqual(Norway.Fødselsnummer(integerLiteral: 220177_72175).kjønn,   .mann)
    XCTAssertEqual(Norway.Fødselsnummer(integerLiteral: 091003_27209).kjønn, .kvinne)
    XCTAssertEqual(Norway.Fødselsnummer(integerLiteral: 080474_29391).kjønn,   .mann)
    XCTAssertEqual(Norway.Fødselsnummer(integerLiteral: 050468_62483).kjønn, .kvinne)
    XCTAssertEqual(Norway.Fødselsnummer(integerLiteral: 281172_65813).kjønn, .kvinne)
    XCTAssertEqual(Norway.Fødselsnummer(integerLiteral: 230197_64966).kjønn,   .mann)
  }

}
