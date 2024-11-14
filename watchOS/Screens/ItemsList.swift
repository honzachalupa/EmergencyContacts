import SwiftUI

struct ItemsListScreen: View {
    @StateObject var store = DataStore()
    
    var body: some View {
        List {
            ForEach(store.dataGrouped.keys.sorted(), id: \.self) { category in
                Section {
                    ForEach(store.dataGrouped[category] ?? [], id: \.name) { item in
                        ItemsList_ItemView(item: item)
                    }
                } header: {
                    HStack {
                        Image(systemName: "cross.fill").foregroundColor(getCategoryColor(category))
                        Text(getCategoryLabel(category))
                    }
                }
            }
        }
    }
}

struct ItemsListScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ItemsListScreen()
        }
    }
}
