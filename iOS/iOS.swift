import SwiftUI
import SwiftData

@main
struct EmergencyContactsApp: App {
    var body: some Scene {
        WindowGroup {
            IndexScreen()
        }
        // .modelContainer(for: [DataItem_.self])
    }
}
