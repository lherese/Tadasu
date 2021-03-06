#if !canImport(ObjectiveC)
import XCTest

extension FylkeTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__FylkeTests = [
        ("testAssociation", testAssociation),
        ("testEndringer2020", testEndringer2020),
        ("testFylkesregister", testFylkesregister),
        ("testMedNavn", testMedNavn),
        ("testMedNummer", testMedNummer),
    ]
}

extension FødselsnummerTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__FødselsnummerTests = [
        ("testDate", testDate),
        ("testFH_nummer", testFH_nummer),
        ("testIntegerLiteral", testIntegerLiteral),
        ("testKjønn", testKjønn),
        ("testLetters", testLetters),
        ("testNumberNormalisation", testNumberNormalisation),
        ("testPersonnummer", testPersonnummer),
        ("testRegistertype", testRegistertype),
        ("testSerie", testSerie),
        ("testValidation", testValidation),
    ]
}

extension KommuneTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__KommuneTests = [
        ("testAssociation", testAssociation),
        ("testKommuneregister", testKommuneregister),
        ("testMedNavn", testMedNavn),
        ("testMedNummer", testMedNummer),
    ]
}

extension KontonummerTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__KontonummerTests = [
        ("testCheckdash", testCheckdash),
        ("testComponentInitialisation", testComponentInitialisation),
        ("testComponents", testComponents),
        ("testIntegerLiteral", testIntegerLiteral),
        ("testLetters", testLetters),
        ("testNext", testNext),
        ("testNumberNormalisation", testNumberNormalisation),
        ("testValidation", testValidation),
    ]
}

extension PoststedTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__PoststedTests = [
        ("testAssociation", testAssociation),
        ("testMedNavn", testMedNavn),
        ("testMedNummer", testMedNummer),
        ("testPostnummerRegister", testPostnummerRegister),
    ]
}

extension TelefonnummerTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__TelefonnummerTests = [
        ("testIntegerLiteral", testIntegerLiteral),
        ("testSerie", testSerie),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FylkeTests.__allTests__FylkeTests),
        testCase(FødselsnummerTests.__allTests__FødselsnummerTests),
        testCase(KommuneTests.__allTests__KommuneTests),
        testCase(KontonummerTests.__allTests__KontonummerTests),
        testCase(PoststedTests.__allTests__PoststedTests),
        testCase(TelefonnummerTests.__allTests__TelefonnummerTests),
    ]
}
#endif
