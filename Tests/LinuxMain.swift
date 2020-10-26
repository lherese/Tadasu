import XCTest

import NorwayTests
import TadasuTests

var tests = [XCTestCaseEntry]()
tests += NorwayTests.__allTests()
tests += TadasuTests.__allTests()

XCTMain(tests)
