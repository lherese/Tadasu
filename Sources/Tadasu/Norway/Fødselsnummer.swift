import Foundation

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

    subscript(range: ClosedRange<Int>) -> Int {
      Int(
        range
          .map {
            self[$0]
          }
          .reduce(into: "") { string, i in
            string.append(String(i))
          }
      )!
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

extension Norway.Fødselsnummer {

  var day: Int {
    let day = self[1...2]

    return day >= 40
      ? day - 40
      : day
  }

  var month: Int {
    let month = self[3...4]

    return month >= 40
      ? month - 40
      : month
  }

  var year: Int {
    self[5...6]
  }

  public var personnummer: Int {
    self[7...9]
  }

  public struct Serie: Equatable {
    let years: Range<Int>
    let values: Range<Int>

    public static let fra1854 = Self(years: 1854 ..< 1900, values: 500 ..<  750)
    public static let fra1900 = Self(years: 1900 ..< 2000, values: 000 ..<  500)
    public static let fra1940 = Self(years: 1940 ..< 2000, values: 900 ..< 1000)
    public static let fra2000 = Self(years: 2000 ..< 2040, values: 500 ..< 1000)

    static let all: [Serie] = [
      .fra1854,
      .fra1900,
      .fra1940,
      .fra2000,
    ]
  }

  public var serie: Serie? {
    guard
      registertype == .fødselsnummer
    else {
      return nil
    }

    for s in Serie.all {
      let century = (s.years.first! / 100) * 100
      let year = century + self.year

      if s.years.contains(year) && s.values.contains(personnummer) {
        return s
      }
    }

    return nil
  }

  var fullYear: Int {
    if let serie = self.serie {
      let year = (serie.years.first! / 100) * 100 + self.year

      return year
    } else {
      let century = year > 40
        ? 1900
        : 2000

      return century + year
    }
  }

  public var fødselsdato: String? {
    guard
      registertype != .FH_nummer
    else {
      return nil
    }

    let month = String(self.month).padding(toLength: 2, withString: "0")
    let day = String(self.day).padding(toLength: 2, withString: "0")

    return "\(fullYear)-\(month)-\(day)"
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
