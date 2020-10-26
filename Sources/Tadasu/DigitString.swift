protocol DigitString: Codable, Hashable, ExpressibleByIntegerLiteral, LosslessStringConvertible {

  var value: String { get }

  var isValid: Bool { get }
  var isValidDigitString: Bool { get }

  init(value: String)

  subscript(index: Int) -> Int? { get }
  subscript(index: Int) -> Character? { get }

  subscript(range: ClosedRange<Int>) -> Int? { get }
  subscript(range: ClosedRange<Int>) -> String? { get }

}

extension DigitString {

  var isValid: Bool {
    isValidDigitString
  }

  var isValidDigitString: Bool {
    value.allSatisfy(\.isWholeNumber)
  }

}

extension DigitString {

  public init(integerLiteral: UInt64) {
    self.init(value: String(integerLiteral))

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

extension DigitString {

  subscript(_ index: Int) -> Character? {
    guard
      (1...value.count).contains(index)
    else {
      return nil
    }

    return value[value.index(value.startIndex, offsetBy: index - 1)]
  }

  subscript(_ index: Int) -> Int? {
    self[index]?.wholeNumberValue
  }

  subscript(range: ClosedRange<Int>) -> String? {
    range
      .map {
        self[$0]!
      }
      .reduce(into: "") { string, i in
        string.append(i)
      }
  }

  subscript(range: ClosedRange<Int>) -> Int? {
    Int(self[range]!)!
  }

}
