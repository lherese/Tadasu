protocol FixedDigitString: DigitString {

  static var count: Int { get }

}

extension FixedDigitString {

  var isValidDigitString: Bool {
    value.count == Self.count && value.allSatisfy(\.isWholeNumber)
  }

}

extension FixedDigitString {

  public init(integerLiteral: UInt64) {
    self.init(value: String(integerLiteral).padding(toLength: Self.count, withString: "0"))

    guard
      isValid
    else {
      preconditionFailure("\(Self.self) as integer literal must be valid")
    }
  }

}

extension FixedDigitString {

  subscript(_ index: Int) -> Character {
    self[index]!
  }

  subscript(_ index: Int) -> Int {
    self[index]!
  }

  subscript(range: ClosedRange<Int>) -> Int {
    self[range]!
  }

  subscript(range: ClosedRange<Int>) -> String {
    self[range]!
  }

}
