extension Norway {

  public enum Kjønn {
    case mann
    case kvinne
  }

  public struct Fødselsnummer {

    let value: String

    var isValid: Bool {
      guard
        value.count == 11,
        value.allSatisfy({ $0.isWholeNumber })
      else {
        return false
      }

      return MOD11(value, weights: [2, 3, 4, 5, 6, 7]) && MOD11(value.prefix(10), weights: [2, 5, 4, 9, 8, 1, 6, 7, 3])
    }

    public var kjønn: Kjønn {
      value[value.index(value.startIndex, offsetBy: 8)].wholeNumberValue! % 2 == 0
        ? .kvinne
        :   .mann
    }

  }

}

extension Norway.Fødselsnummer: LosslessStringConvertible {

  public var description: String {
    value.prefix(6) + " " + value.suffix(5)
  }

  public init?<T: StringProtocol>(_ value: T) {
    self.value = value
      .filter {
        !$0.isWhitespace
      }
      .reduce(into: "") { string, char in
        if let nValue = char.wholeNumberValue {
          string.append(String(nValue))
        } else {
          string.append(char)
        }
      }

    guard
      isValid
    else {
      return nil
    }
  }

}

extension Norway.Fødselsnummer: ExpressibleByIntegerLiteral {

  public init(integerLiteral: UInt64) {
    self.value = String(integerLiteral)
      .padding(toLength: 11, withString: "0")

    guard
      isValid
    else {
      preconditionFailure("Fødselsnummer as integer literals must be valid")
    }
  }

}
