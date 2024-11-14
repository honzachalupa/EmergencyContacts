import SwiftUI

struct ItemsList_FilterView: View {
    @Binding var filteredDataGrouped: [DataItem.CategoryType: [DataItem]]
    
    @StateObject var store = DataStore()
    
    @State var categories: [DataItem.CategoryType] = []
    @State var districts: [DataItem.AddressType.DistrictType] = []
    @State var keywords: [DataItem.AddressType.DistrictType] = []
    @State var selectedCategory: DataItem.CategoryType = "all"
    @State var selectedDistrict: DataItem.AddressType.DistrictType = "all"
    @State var selectedKeyword: DataItem.KeywordType = "all"
    
    var filterChanged: Int {
        var hasher = Hasher()
        
        hasher.combine(selectedCategory)
        hasher.combine(selectedDistrict)
        hasher.combine(selectedKeyword)
        
        return hasher.finalize()
    }
    
    func reset() {
        selectedCategory = "all"
        selectedDistrict = "all"
        selectedKeyword = "all"
    }
    
    var body: some View {
        GeometryReader { screen in
            Menu(content: {
                Menu(content: {
                    Picker(selection: $selectedCategory,
                           label: Text("Category")
                    ) {
                        ForEach(categories, id: \.self) {
                            Text(getCategoryLabel($0))
                                .tag($0)
                        }
                    }
                    
                    Divider()
                    
                    Picker(selection: $selectedKeyword,
                           label: Text("Sub-category")
                    ) {
                        ForEach(keywords.filter { $0 != "adult-care" }, id: \.self) {
                            Text(getKeywordLabel($0))
                                .tag($0)
                        }
                    }
                }, label: {
                    Text("Category")
                })
                
                Menu(content: {
                    Picker(selection: $selectedDistrict,
                           label: Text("District")
                    ) {
                        ForEach(districts, id: \.self) {
                            Text($0)
                                .tag($0)
                        }
                    }
                }, label: {
                    Text("District")
                })
                
                Button(role: .destructive, action: reset) {
                    Label("Reset", systemImage: "arrow.clockwise")
                }
            }, label: {
                Image(systemName: "line.3.horizontal.decrease.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.white)
                    .padding(25)
                    .background(
                        Circle()
                            .frame(width: 50, height: 50)
                    )
            })
            .menuOrder(.fixed)
            .menuStyle(.button)
            .position(
                x: screen.size.width - 35,
                y: screen.size.height - 35
            )
            .onChange(of: store.data) {
                filteredDataGrouped = store.dataGrouped
                
                categories = store.data.map { $0.category }.unique()
                districts = store.data.map { $0.address.district }.unique().sorted(using: .localizedStandard)
                keywords = store.data.compactMap { $0.keywords }.filter({ $0.count > 0 }).flatMap { $0 }.unique()
            }
            .onChange(of: filterChanged) {
                let filtered = store.data.filter { item in
                    let categoryCondition = (item.category == selectedCategory || selectedCategory == "all")
                    let districtCondition = (item.address.district == selectedDistrict || selectedDistrict == "all")
                    
                    var keywordsCondition = false
                    if let _keywords = item.keywords {
                        keywordsCondition = _keywords.contains(selectedKeyword) || selectedKeyword == "all"
                    }
                    
                    return categoryCondition && districtCondition && keywordsCondition
                }
                
                filteredDataGrouped = groupByCategory(filtered)
            }
        }
    }
}
