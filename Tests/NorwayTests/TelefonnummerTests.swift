import XCTest

import Tadasu

final class TelefonnummerTests: XCTestCase {

  func testIntegerLiteral() {
    let twelve: Norway.Telefonnummer  = 58_01_23_45_67_89
    let eight1: Norway.Telefonnummer  =        800_05_555
    let eight2: Norway.Telefonnummer  =       98_76_54_32
    let six:    Norway.Telefonnummer  =           116_117
    let five:   Norway.Telefonnummer  =             05555
    let four:   Norway.Telefonnummer  =              1880
    let three:  Norway.Telefonnummer  =               110

    XCTAssertEqual(twelve.description, "58 01 23 45 67 89")
    XCTAssertEqual(eight1.description,        "800 05 555")
    XCTAssertEqual(eight2.description,       "98 76 54 32")
    XCTAssertEqual(six.description,              "116 117")
    XCTAssertEqual(five.description,               "05555")
    XCTAssertEqual(four.description,                "1880")
    XCTAssertEqual(three.description,                "110")
  }

  func testSerie() {
    XCTAssertNil(Norway.Telefonnummer("800"))
    XCTAssertNotNil(Norway.Telefonnummer("800 05 555"))
    XCTAssertEqual(Norway.Telefonnummer("110")?.serie.mobilnummer, false)
    XCTAssertEqual(Norway.Telefonnummer("116 117")?.serie.lengde, 6)
    XCTAssertEqual(Norway.Telefonnummer("58 01 23 45 67 89")?.serie.lengde, 12)
    XCTAssertEqual(Norway.Telefonnummer("98 76 54 32")?.serie.mobilnummer, true)
  }

}
