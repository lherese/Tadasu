fileprivate func expandWeights(for size: Int, _ values: [Int]) -> [Int] {
  var weights: [Int] = []

  for i in 0 ..< size {
    weights.append(values[i % values.count])
  }

  return weights
}

fileprivate let characterTable: [String?] = [
  nil,
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "-",
  "0",
]

func MOD11<T: StringProtocol>(_ candidate: T, weights: [Int]) -> String {
  let weights = expandWeights(for: candidate.count, weights)

  var sum = 0

  for (weight, number) in zip(weights, candidate.reversed()) {
    guard
      let number = number.wholeNumberValue
    else {
      preconditionFailure("non-number encountered")
    }

    sum += weight * number
  }

  return candidate + characterTable[11 - (sum % 11)]!
}

func MOD11<T: StringProtocol>(_ candidate: T, weights: [Int]) -> Bool {
  let weights = [1] + expandWeights(for: candidate.count - 1, weights)

  var sum = 0

  for (weight, number) in zip(weights, candidate.reversed()) {
    guard
      let number = number.wholeNumberValue
    else {
      preconditionFailure("non-number encountered")
    }

    sum += weight * number
  }

  return (sum % 11) == 0
}
