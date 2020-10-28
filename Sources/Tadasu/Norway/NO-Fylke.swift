import Foundation

extension Norway {

  public typealias Fylkesnummer = Fylke.Nummer

  public struct Fylke: Codable, Hashable {

    public struct Nummer: FixedDigitString {

      let value: String

      static let count = 2

      var isValid: Bool {
        isValidDigitString && Fylke.alle.map(\.nummer).contains(self)
      }

    }

    public let navn: Set<String>

    public let nummer: Nummer
    public let gyldig: Bool

    public static var alle: Set<Self> = {
      try! JSONDecoder().decode(
        Set<Self>.self,
        from: Data(contentsOf: Tadasu.bundle.url(forResource: "NO-fylker", withExtension: "json")!)
      )
    }()

    public static var gyldige: Set<Self> = {
      alle.filter(\.gyldig)
    }()

    public static func med(nummer: String) -> Self? {
      Nummer(nummer).flatMap { med(nummer: $0) }
    }

    public static func med(navn: String) -> Self? {
      alle.first { $0.navn.contains(navn) }
    }

    public static func med(nummer: Nummer) -> Self? {
      alle.first { $0.nummer == nummer }
    }

    public var kommuner: Set<Kommune> {
      Kommune.alle.filter { $0.nummer.fylkesnummer == self.nummer }
    }

  }

}
