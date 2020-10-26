protocol MOD11DigitString: FixedDigitString {

  associatedtype WeightsType

  static var weights: WeightsType { get }

}

extension MOD11DigitString where WeightsType == [Int] {

  var isValid: Bool {
    isValidDigitString && MOD11(value, weights: Self.weights)
  }

}

extension MOD11DigitString where WeightsType == (inner: [Int], outer: [Int]) {

  var isValid: Bool {
    isValidDigitString && MOD11(value, weights: Self.weights.outer) && MOD11(value.prefix(Self.count - 1), weights: Self.weights.inner)
  }

}
