#if !canImport(ObjectiveC)
import XCTest

extension FødselsnummerTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__FødselsnummerTests = [
        ("testIntegerLiteral", testIntegerLiteral),
        ("testKjønn", testKjønn),
        ("testLetters", testLetters),
        ("testNumberNormalisation", testNumberNormalisation),
        ("testValidation", testValidation),
    ]
}

extension MOD11Tests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__MOD11Tests = [
        ("testChecksum", testChecksum),
        ("testRoundTrip", testRoundTrip),
        ("testVerify", testVerify),
    ]
}

extension PaddingTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__PaddingTests = [
        ("testLeftFill", testLeftFill),
        ("testLeftPad", testLeftPad),
        ("testLeftTrim", testLeftTrim),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FødselsnummerTests.__allTests__FødselsnummerTests),
        testCase(MOD11Tests.__allTests__MOD11Tests),
        testCase(PaddingTests.__allTests__PaddingTests),
    ]
}
#endif
