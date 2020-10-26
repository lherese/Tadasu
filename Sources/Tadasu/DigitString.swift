protocol DigitString: Codable, Hashable, ExpressibleByIntegerLiteral, LosslessStringConvertible {

  var value: String { get }

  static var count: Int { get }

  var isValid: Bool { get }
  var isValidDigitString: Bool { get }

  init(value: String)

}

extension DigitString {

  var isValidDigitString: Bool {
    value.count == Self.count && value.allSatisfy(\.isWholeNumber)
  }

}

extension DigitString {

  public init(integerLiteral: UInt64) {
    self.init(value: String(integerLiteral).padding(toLength: Self.count, withString: "0"))

    guard
      isValid
    else {
      preconditionFailure("\(Self.self) as integer literal must be valid")
    }
  }

}

extension DigitString {

  public var description: String {
    value
  }

  public init?<T: StringProtocol>(_ value: T) {
    self.init(value: value
      .filter {
        !$0.isWhitespace && !$0.isPunctuation
      }
      .reduce(into: "") { string, char in
        if let nValue = char.wholeNumberValue {
          string.append(String(nValue))
        } else {
          string.append(char)
        }
      }
    )

    guard
      isValid
    else {
      return nil
    }
  }

}
