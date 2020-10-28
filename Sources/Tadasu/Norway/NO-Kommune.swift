import Foundation

extension Norway {

  public struct Kommune: Codable, Hashable {

    public struct Nummer: FixedDigitString {

      let value: String

      static let count = 4

      public var fylkesnummer: String {
        self[1...2]
      }

      var isValid: Bool {
        isValidDigitString
          && Kommune.alle.map(\.nummer).contains(self)
      }

    }

    public let navn: Set<String>

    public let nummer: Nummer
    public let gyldig: Bool

    static var tableURL: URL = {
      #if DEBUG
      let bundle = Bundle(url: URL(fileURLWithPath: "\(NSString(#filePath).deletingLastPathComponent)/../../../.build/debug/Tadasu_Tadasu.bundle"))!
      #else
      let bundle = Bundle.module
      #endif

      return bundle.url(forResource: "NO-kommuner", withExtension: "json")!
    }()

    public static var alle: Set<Self> = {
      try! JSONDecoder().decode(
        Set<Self>.self,
        from: Data(contentsOf: tableURL)
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

  }

}
