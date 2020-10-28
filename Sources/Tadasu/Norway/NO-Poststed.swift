import Foundation

extension Norway {

  public typealias Postnummer = Poststed.Nummer

  public struct Poststed: Codable, Hashable {

    public struct Nummer: FixedDigitString {

      let value: String

      static let count = 4

      var isValid: Bool {
        isValidDigitString
          && Poststed.alle.map(\.nummer).contains(self)
      }

    }

    public enum Kategori: String, RawRepresentable, Codable, Hashable {
      case B
      case F
      case G
      case P
      case S
    }

    public let navn: String

    public let nummer: Nummer
    public let kommunenummer: Kommunenummer

    public let kategori: Kategori

    public static var alle: Set<Self> = {
      try! JSONDecoder().decode(
        Set<Self>.self,
        from: Data(contentsOf: Tadasu.bundle.url(forResource: "NO-poststeder", withExtension: "json")!)
      )
    }()

    public static func med(nummer: String) -> Self? {
      Nummer(nummer).map { med(nummer: $0) }
    }

    public static func med(navn: String) -> Set<Self> {
      alle.filter { $0.navn == navn }
    }

    public static func med(nummer: Postnummer) -> Self {
      alle.first { $0.nummer == nummer }!
    }

  }

}

extension Norway.Poststed {

  public var kommune: Norway.Kommune {
    Norway.Kommune.med(nummer: kommunenummer)
  }

}

extension Norway.Kommune {

  public var poststeder: Set<Norway.Poststed> {
    Norway.Poststed.alle.filter { $0.kommunenummer == self.nummer }
  }

}
