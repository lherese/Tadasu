extension Norway {

  public struct Kontonummer: MOD11DigitString {

    let value: String

    static let count = 11

    static let weights = [
      2, 3, 4, 5, 6, 7
    ]

    @available(macOS 10.15, *)
    public var bankregisternummer: some StringProtocol {
      value.prefix(4)
    }

    @available(macOS 10.15, *)
    public var kontogruppe: some StringProtocol {
      value.prefix(6).suffix(2)
    }

    @available(macOS 10.15, *)
    public var kundekontonummer: some StringProtocol {
      value.suffix(5).prefix(4)
    }

    @available(macOS 10.15, *)
    public var neste: Kontonummer? {
      guard
        Int(kundekontonummer)! < 9999
      else {
        return nil
      }

      for i in (Int(kundekontonummer)! + 1)...9999 {
        if let kontonummer = Self(bankregisternummer: Int(bankregisternummer)!, kontogruppe: Int(kontogruppe)!, kundekontonummer: i) {
          return kontonummer
        }
      }

      return nil
    }

  }

}

extension Norway.Kontonummer {

  public init?(bankregisternummer: Int, kontogruppe: Int, kundekontonummer: Int) {
    guard
      (0000...9999).contains(bankregisternummer),
      (  00...99  ).contains(kontogruppe),
      (0000...9999).contains(kundekontonummer)
    else {
      return nil
    }

    let digitString = [
      String(bankregisternummer).padding(toLength: 4, withString: "0"),
      String(kontogruppe)       .padding(toLength: 2, withString: "0"),
      String(kundekontonummer)  .padding(toLength: 4, withString: "0"),
    ].reduce("", +)

    self.value = MOD11(digitString, weights: Self.weights)

    guard
      isValid
    else {
      return nil
    }
  }

  public var description: String {
    value.prefix(4) + "." + value.prefix(6).suffix(2) + "." + value.suffix(5)
  }

}
