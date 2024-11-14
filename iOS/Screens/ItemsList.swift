import SwiftUI
import CoreLocation

struct ItemsListScreen: View {
    let locationManager = CLLocationManager()
    
    @State var filteredDataGrouped: [DataItem.CategoryType: [DataItem]] = [:]
    
    var body: some View {
        ZStack {
            if filteredDataGrouped.isEmpty {
                Text("No items were found based on the specified criteria. Please adjust the filter.")
                    .multilineTextAlignment(.center)
            } else {
                List {
                    ForEach(filteredDataGrouped.keys.sorted(), id: \.self) { category in
                        Section {
                            ForEach(filteredDataGrouped[category] ?? [], id: \.name) { item in
                                ItemsList_ItemView(item: item)
                                    .padding(.top)
                            }
                        } header: {
                            HStack {
                                Image(systemName: "cross.fill")
                                    .foregroundColor(getCategoryColor(category))
                                
                                Text(getCategoryLabel(category))
                            }
                        }
                    }
                }
                .listStyle(.grouped)
            }
            
            ItemsList_FilterView(filteredDataGrouped: $filteredDataGrouped)
        }
        /* .onAppear(perform: {
            let place = filteredDataGrouped["hospital"]!.first!
            let placeCoordinates = place.coordinates
            
            print(
                locationManager.location!.coordinate,
                filteredDataGrouped["hospital"]!.first!.coordinates,
                locationManager.location!.distance(
                    from: CLLocation(
                        latitude: placeCoordinates.latitude,
                        longitude: placeCoordinates.latitude
                    )
                ) / 1000,
                CLLocation(
                    latitude: placeCoordinates.latitude,
                    longitude: placeCoordinates.latitude
                ).distance(from: locationManager.location!) / 1000
            )
        })
        .onChange(of: store.data) {
            let place = filteredDataGrouped["hospital"]!.first!
            let placeCoordinates = place.coordinates
            
            print(
                locationManager.location!.coordinate,
                filteredDataGrouped["hospital"]!.first!.coordinates,
                locationManager.location!.distance(
                    from: CLLocation(
                        latitude: placeCoordinates.latitude,
                        longitude: placeCoordinates.latitude
                    )
                ) / 1000,
                CLLocation(
                    latitude: placeCoordinates.latitude,
                    longitude: placeCoordinates.latitude
                ).distance(from: locationManager.location!) / 1000
            )
        } */
    }
}

struct ItemsListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ItemsListScreen()
    }
}
