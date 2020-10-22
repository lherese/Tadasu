extension String {

  func padding(toLength: Int, withString padding: String) -> String {
    let length = count

    if toLength == length {
      return self
    } else if toLength < length {
      return String(suffix(toLength))
    } else if toLength > length {
      let rLength = toLength - length

      let padding = String(repeating: padding, count: rLength)

      return padding.prefix(rLength) + self
    } else {
      preconditionFailure("An unreachable state was reached")
    }
  }

}
