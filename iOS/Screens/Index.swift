import SwiftUI
// import Contacts

struct IndexScreen: View {
    @State private var isSheetOpened: Bool = true
    @State private var initialSheetDetent = PresentationDetent.medium
    @State private var isIpadNavigationExpanded = NavigationSplitViewVisibility.all
    @State private var selectedTabKey: TabKey = .map
    @State private var selectedTabKey_iPad: TabKey? = .list
    
    var body: some View {
        if getDeviceName() == .iPad {
            NavigationSplitView(columnVisibility: $isIpadNavigationExpanded) {
                List(selection: $selectedTabKey_iPad) {
                    Section {
                        Label(navigationTitleForSelectedTab(.list), systemImage: "list.bullet")
                            .tag(TabKey.list)
                    
                        Label(navigationTitleForSelectedTab(.phoneNumbers), systemImage: "phone.fill")
                            .tag(TabKey.phoneNumbers)
                    }
                }
                .navigationTitle("Menu")
            } content: {
                switch selectedTabKey_iPad {
                    case .phoneNumbers: IzsScreen()
                    default: ItemsListScreen()
                }
            } detail: {
                MapScreen()
            }
            .navigationSplitViewStyle(.balanced)
        } else {
            NavigationStack {
                DataErrorHandlerView() {
                    TabView(selection: $selectedTabKey) {
                        IzsScreen().tabItem {
                            Label(navigationTitleForSelectedTab(.phoneNumbers), systemImage: "phone.fill")
                        }.tag(TabKey.phoneNumbers)
                        
                        MapScreen().tabItem {
                            Label(navigationTitleForSelectedTab(.map), systemImage: "map")
                        }.tag(TabKey.map)
                        
                        ItemsListScreen().tabItem {
                            Label(navigationTitleForSelectedTab(.list),systemImage: "list.bullet")
                        }.tag(TabKey.list)
                    }
                    .navigationTitle(navigationTitleForSelectedTab(selectedTabKey))
                    .toolbarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItemGroup(placement: .topBarTrailing) {
                            NavigationLink(destination: SettingsView()) {
                                Image(systemName: "gearshape")
                            }
                        }
                    }
                }
            }
        }
        /* .onAppear() {
            var status: Bool = false
            var store = CNContactStore()

            store.requestAccess(for: CNEntityType.contacts) { hasPermission, error in
                if error != nil {
                    print(error!)
                }
                
                status = hasPermission
            }
        } */
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
