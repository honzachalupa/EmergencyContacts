import SwiftUI

func getCategoryColor(_ category: DataItem.CategoryType) -> Color {
    switch category {
        case "pharmacy":
            return .orange
        case "vet":
            return .yellow
        default:
            return .red
    }
}
