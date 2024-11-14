import SwiftUI
import MapKit

struct MapScreen: View {
    var isZoomEnabled: Bool = true
    
    let locationManager = CLLocationManager()
    
    @StateObject var store = DataStore()
    
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var selectedMarker: DataItem?
    
    var body: some View {
        Map(
            initialPosition: position,
            interactionModes: isZoomEnabled ? [.pan, .zoom] : [.pan],
            selection: $selectedMarker
        ) {
            UserAnnotation()
            
            ForEach(store.dataGrouped.keys.sorted(), id: \.self) { category in
                if let items = store.dataGrouped[category] {
                    ForEach(items, id: \.id) { item in
                        Marker(
                            item.name,
                            systemImage: "cross.fill",
                            coordinate: item.coordinates
                        )
                        .tint(getCategoryColor(item.category))
                        .tag(item)
                    }
                }
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .mapControls {
            MapUserLocationButton()
        }
        .sheet(item: $selectedMarker) { marker in
            ItemsList_ItemView(item: marker)
                .padding()
                .presentationDetents([.medium])
        }
        .onAppear {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

#Preview {
    MapScreen()
}

// https://developer.apple.com/forums/thread/744107#744107021
/* final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var location: CLLocation = CLLocation(
        coordinate: CLLocationCoordinate2D(
            latitude: 51.500685,
            longitude: -0.124570
        ),
        altitude: .zero,
        horizontalAccuracy: .zero,
        verticalAccuracy: .zero,
        timestamp: Date.now
    )
    
    @Published var direction: CLLocationDirection = .zero
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        Task { [weak self] in
            try? await self?.requestAuthorization()
        }
    }
    
    func requestAuthorization() async throws {
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.forEach { [weak self] location in
            Task { @MainActor [weak self]  in
                self?.location = location
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        Task { @MainActor [weak self]  in
            self?.direction = newHeading.trueHeading
        }
    }
    
} */

/*
    struct MarkerItem: Identifiable {
     let id = UUID();
     let name: String;
     let category: String;
     let coordinates: CLLocationCoordinate2D
    }

    struct MapView: View {
     var data: [DataItem.CategoryType: [DataItem]]
     
     @State private var selectedItemId: UUID?
     @State private var selectedItem: MarkerItem?
     
     let markers = [
         MarkerItem(
             name: "Marker 1",
             category: "hospital",
             coordinates: CLLocationCoordinate2D(
                 latitude: 0,
                 longitude: 0
             )
         ),
         MarkerItem(
             name: "Marker 2",
             category: "pharmacy",
             coordinates: CLLocationCoordinate2D(
                 latitude: 1,
                 longitude: 1
             )
         )
     ];
     
     var body: some View {
         Map(selection: $selectedItemId) {
             ForEach(markers) { marker in
                 Marker(
                     marker.name,
                     systemImage: "cross.fill",
                     coordinate: marker.coordinates
                 )
                 .tint(getCategoryColor(marker.category))
             }
         }
         .onChange(of: selectedItemId, { _, id in
             selectedItem = markers.first(where: { $0.id == id})
         })
         .mapControlVisibility(.hidden)
         .navigationTitle(selectedItem.name)
     }
    }

    #Preview {
     MapView(data: mockedItems)
    }
*/
