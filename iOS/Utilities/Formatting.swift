func formatPhoneNumber(_ value: DataItem.ContactType.PhoneNumberType) -> String {
    let digits = String(value).filter { "0"..."9" ~= $0 }
    let segmentLengths = [3, 3, 3]
    var formattedNumber = ""
    var index = digits.startIndex

    for length in segmentLengths {
        let segmentEnd = digits.index(index, offsetBy: length, limitedBy: digits.endIndex) ?? digits.endIndex
        let segment = digits[index..<segmentEnd]
        if !formattedNumber.isEmpty {
            formattedNumber += " "
        }
        formattedNumber += segment
        if segmentEnd == digits.endIndex {
            break
        }
        index = segmentEnd
    }

    return "+420 \(formattedNumber)"
}
