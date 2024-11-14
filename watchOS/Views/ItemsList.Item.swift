import SwiftUI
import MapKit

struct ItemsList_ItemView: View {
    var item: DataItem

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.name).font(.headline)
            
            Spacer()
            
            Text("\(item.address.street), \(item.address.district)")
            
            if let note = item.address.note {
                Text("(\(note))")
                    .opacity(0.6)
            }
            
            Spacer()
            
            NavigateButton(name: item.name, coordinates: item.coordinates)
        }
        .padding(.vertical, 10)
    }
}

struct NavigateButton: View {
    let name: DataItem.NameType;
    let coordinates: DataItem.CoordinatesType;
    
    var body: some View {
        Button("Navigate") {
            let destination = MKMapItem(
                placemark: MKPlacemark(
                    coordinate: coordinates
                )
            )
            
            destination.name = name
                    
            MKMapItem.openMaps(
              with: [destination],
              launchOptions: [
                MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
              ]
            )
        }
        .padding(.leading, 10)
        .buttonStyle(.bordered)
    }
}

struct ItemsList_ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsList_ItemView(item: mockedItems.first!)
    }
}
