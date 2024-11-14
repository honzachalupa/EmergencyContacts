func navigationTitleForSelectedTab(_ key: TabKey) -> String {
    switch key {
        case .phoneNumbers:
            return String(localized: "Phone Numbers")
        case .map:
            return String(localized: "Map")
        case .list:
            return String(localized: "List")
    }
}

func getKeywordLabel(_ keyword: DataItem.KeywordType) -> String {
    switch keyword.lowercased() {
        case "adult-care":
            return String(localized: "Adult Care")
        case "child-care":
            return String(localized: "Child Care")
        case "stomatology":
            return String(localized: "Stomatology")
        case "ophthalmology":
            return String(localized: "Ophthalmology")
        default:
            return keyword
    }
}

func getCategoryLabel(_ category: DataItem.CategoryType) -> String {
    switch category.lowercased() {
        case "hospital":
            return String(localized: "Hospitals")
        case "pharmacy":
            return String(localized: "Pharmacies")
        case "vet":
            return String(localized: "Vets")
        default:
            return category
    }
}
