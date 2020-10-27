protocol DynamicDigitString: DigitString {

  static func count(for: UInt64) -> Int

}

extension DynamicDigitString {

  var isValid: Bool {
    isValidDigitString && value.count == self.count
  }

  var count: Int {
    Self.count(for: UInt64(value)!)
  }

}

extension DynamicDigitString {

  public init(integerLiteral: UInt64) {
    self.init(value: String(integerLiteral).padding(toLength: Self.count(for: integerLiteral), withString: "0"))

    guard
      isValid
    else {
      preconditionFailure("\(Self.self) as integer literal must be valid")
    }
  }

}

