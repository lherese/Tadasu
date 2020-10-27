extension Norway {

  public struct Telefonnummer: DynamicDigitString {

    public struct Serie {
      let nummer: Range<UInt64>
      let format: String

      public let lengde: Int
      public let mobilnummer: Bool

      init(_ nummer: ClosedRange<UInt64>, lengde: Int = 8, format: String = "## ## ## ##", mobilnummer: Bool = false) {
        self.nummer = Range(nummer)
        self.format = format

        self.lengde = lengde
        self.mobilnummer = mobilnummer
      }

      func contains(_ value: UInt64) -> Bool {
        nummer.contains(value)
      }

      public static let testnummer = Serie(    01000000 ...     01999999)
      public static let femsifret  = Serie(       02000 ...        09999, lengde: 5, format: "#####")
      public static let EØS_nummer = Serie(      116000 ...       116999, lengde: 6, format: "### ###")
      public static let spesial_1  = Serie(         110 ...          115, lengde: 3, format: "###")
      public static let spesial_2  = Serie(         117 ...          179, lengde: 3, format: "###")
      public static let opplysning = Serie(        1800 ...         1899, lengde: 4, format: "####")
      public static let spesial_3  = Serie(         190 ...          199, lengde: 3, format: "###")
      public static let fast_23    = Serie(    20000000 ...     39999999)
      public static let mobil_4    = Serie(    40000000 ...     49999999, mobilnummer: true)
      public static let fast_5     = Serie(    50000000 ...     57999999)
      public static let iot_12     = Serie(580000000000 ... 589999999999, lengde: 12, format: "## ## ## ## ## ##")
      public static let iot_8      = Serie(    59000000 ...     59999999)
      public static let fast_67    = Serie(    60000000 ...     79999999)
      public static let spesial_8  = Serie(    80000000 ...     89999999, format: "### ## ###")
      public static let mobil_9    = Serie(    90000000 ...     99999999, mobilnummer: true)

      static let all: [Serie] = [
        .testnummer,
        .femsifret,
        .EØS_nummer,
        .spesial_1,
        .spesial_2,
        .opplysning,
        .spesial_3,
        .fast_23,
        .mobil_4,
        .fast_5,
        .iot_12,
        .iot_8,
        .fast_67,
        .spesial_8,
        .mobil_9,
      ]
    }

    let value: String

    public var serie: Serie {
      for serie in Serie.all {
        if serie.contains(UInt64(value)!) {
          return serie
        }
      }

      preconditionFailure()
    }

    static func count(for value: UInt64) -> Int {
      for serie in Serie.all {
        if serie.contains(value) {
          return serie.lengde
        }
      }

      return 0
    }

  }

}

extension Norway.Telefonnummer {

  public var description: String {
    var number = value

    return String(serie.format.map({ $0 == "#" ? number.removeFirst() : $0 }))
  }

}
