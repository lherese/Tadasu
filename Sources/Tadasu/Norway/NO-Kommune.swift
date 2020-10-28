import Foundation

extension Norway {

  public struct Kommune: Codable, Hashable {

    public struct Nummer: FixedDigitString {

      let value: String

      static let count = 4

      public var fylkesnummer: Fylke.Nummer {
        Fylke.Nummer(value: self[1...2])
      }

      public var løpenummer: Int {
        self[3...4]
      }

      var isValid: Bool {
        isValidDigitString
          && Kommune.alle.map(\.nummer).contains(self)
      }

    }

    public let navn: Set<String>

    public let nummer: Nummer
    public let gyldig: Bool

    public static var alle: Set<Self> = {
      try! JSONDecoder().decode(
        Set<Self>.self,
        from: Data(contentsOf: Tadasu.bundle.url(forResource: "NO-kommuner", withExtension: "json")!)
      )
    }()

    public static var gyldige: Set<Self> = {
      alle.filter(\.gyldig)
    }()

    public static func med(nummer: String) -> Self? {
      guard
        let nummer = Nummer(nummer)
      else {
        return nil
      }

      return alle.first { $0.nummer == nummer }
    }

    public static func med(navn: String) -> Self? {
      alle.first { $0.navn.contains(navn) }
    }

    public var fylke: Fylke {
      Fylke.med(nummer: nummer.fylkesnummer)!
    }

  }

}
