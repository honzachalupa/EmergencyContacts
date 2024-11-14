import SwiftUI

func groupByCategory(_ data: [DataItem]) -> [DataItem.CategoryType: [DataItem]] {
    return Dictionary(grouping: data, by: { $0.category })
}

extension Array where Element: Hashable {
  func unique() -> [Element] {
    Array(Set(self))
  }
}
