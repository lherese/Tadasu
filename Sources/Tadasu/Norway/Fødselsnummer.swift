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

    subscript(_ index: Int) -> Int {
      guard
        (1...11).contains(index)
      else {
        preconditionFailure("Invalid index")
      }

      return value[value.index(value.startIndex, offsetBy: index - 1)].wholeNumberValue!
    }

    public var kjønn: Kjønn {
      self[9] % 2 == 0
        ? .kvinne
        :   .mann
    }

  }

}

public extension Norway.Fødselsnummer {

  enum Registertype {
    case fødselsnummer
    case D_nummer
    case H_nummer
    case FH_nummer
  }

  var registertype: Registertype {
    if (4...7).contains(self[1]) {
      return .D_nummer
    } else if (4...5).contains(self[3]) {
      return .H_nummer
    } else if (8...9).contains(self[1]) {
      return .FH_nummer
    } else {
      return .fødselsnummer
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
