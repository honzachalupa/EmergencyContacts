import SwiftUI

struct IndexScreen: View {
    @State private var isSheetOpened: Bool = true
    @State private var initialSheetDetent = PresentationDetent.medium
    @State private var selectedTabKey: TabKey = .map
    
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
    
    var body: some View {
        NavigationStack {
            DataErrorHandlerView() {
                TabView(selection: $selectedTabKey) {
                    IzsScreen().tabItem {
                        Label(navigationTitleForSelectedTab(.phoneNumbers), systemImage: "phone.fill")
                    }.tag(TabKey.phoneNumbers)
                    
                    MapScreen(isZoomEnabled: false).tabItem {
                        Label(navigationTitleForSelectedTab(.map), systemImage: "map")
                    }.tag(TabKey.map)
                    
                    ItemsListScreen().tabItem {
                        Label(navigationTitleForSelectedTab(.list),systemImage: "list.bullet")
                    }.tag(TabKey.list)
                }
                .navigationTitle(navigationTitleForSelectedTab(selectedTabKey))
                .tabViewStyle(.verticalPage)
            }
        }
    }
}

struct IndexScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IndexScreen()
                .environment(\.locale, .init(identifier: "cs"))
            
            IndexScreen()
                .environment(\.locale, .init(identifier: "en"))
        }
    }
}
