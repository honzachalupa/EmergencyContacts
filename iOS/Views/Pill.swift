import SwiftUI

enum Variant {
    case gray
}

struct PillView: View {
    var value: String
    var variant: Variant?
    
    @State var backgroundColor: Color = .accentColor
    @State var foregroundColor: Color = .white
    
    var body: some View {
        Text(value)
            .font(.caption)
            .foregroundStyle(foregroundColor)
            .lineLimit(1)
            .padding(.horizontal, 10)
            .padding(.vertical, 3)
            .background(
                Capsule()
                    .fill(backgroundColor)
            )
            .padding(-2)
            .onAppear() {
                if variant == .gray {
                    backgroundColor = .primary.opacity(0.15)
                    foregroundColor = .primary
                }
            }
    }
}

struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            PillView(value: "Value 1", variant: .gray)
            PillView(value: "Value 2")
            PillView(value: "Value 3")
        }
    }
}
