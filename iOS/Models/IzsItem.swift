import SwiftUI

struct IzsDataItem {
    let name: String
    let phoneNumber: Int
    let color: Color
}

let izsFeaturedItem: IzsDataItem = .init(
    name: String(localized: "International Emergency Service"),
    phoneNumber: 112,
    color: .green
)

let izsItems: [IzsDataItem] = [
    .init(
        name: String(localized: "Medical Service"),
        phoneNumber: 155,
        color: .red
    ),
    .init(
        name: String(localized: "Firefighters"),
        phoneNumber: 150,
        color: .orange
    ),
    .init(
        name: String(localized: "Police"),
        phoneNumber: 158,
        color: .blue
    ),
    .init(
        name: String(localized: "Municipal Police"),
        phoneNumber: 156,
        color: .blue.opacity(0.6)
    ),
]
