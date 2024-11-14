import SwiftUI

struct DataErrorHandlerView<Content: View>: View {
    @ViewBuilder let content: () -> Content
    
    @StateObject var store = DataStore()
    
    var body: some View {
        ZStack {
            if store.data.count > 0 && store.errorMessage == nil {
                self.content()
            } else if let errorMessage = store.errorMessage {
                Text(errorMessage)
            } else {
                ProgressView(label: {
                    Text("Loading...")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.top, 10)
                })
                .progressViewStyle(CircularProgressViewStyle())
            }
        }
    }
}
