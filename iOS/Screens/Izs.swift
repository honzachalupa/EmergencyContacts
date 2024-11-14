import SwiftUI

struct IzsScreen: View {
    var body: some View {
        VStack {
            Izs_ItemView(item: izsFeaturedItem, featured: true)
                .padding(.bottom, 3)
            
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), spacing: 10) {
                ForEach(izsItems, id: \.name) { item in
                    Izs_ItemView(item: item)
                }
            }
            
            Text("Recommendation: Save these contacts directly into your iPhone contacts so you always have them at hand.")
                .font(.footnote)
                .opacity(0.6)
                .padding(.top, 10)
            
            Spacer()
        }
        .padding()
    }
}

struct IzsScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IzsScreen()
                .environment(\.locale, .init(identifier: "cs"))
            
            IzsScreen()
                .environment(\.locale, .init(identifier: "en"))
        }
    }
}
