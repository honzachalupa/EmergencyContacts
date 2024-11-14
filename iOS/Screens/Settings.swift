import SwiftUI

struct SettingsView: View {
    func openSystemSettings() {
    #if os(iOS)
        if let bundleId = Bundle.main.bundleIdentifier,
            let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)")
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    #endif
    }
    
    var body: some View {
        List {
            Section {
                Button(action: openSystemSettings, label: {
                    Text("Change location service settings")
                })
            } header: {
                Text("Location Service")
            }
        }
    }
}

#Preview {
    SettingsView()
}
