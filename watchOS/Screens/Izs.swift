import SwiftUI

struct IzsScreen: View {
    var body: some View {
        List {
            Izs_ItemView(item: izsFeaturedItem)
                .padding(.bottom, 3)
            
            ForEach(izsItems, id: \.name) { item in
                Izs_ItemView(item: item)
            }
        }
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
