
import SwiftUI
import MapKit

var fallbackPosition = MapCameraPosition.region(
    MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 50.08804,
            longitude: 14.42076
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.2,
            longitudeDelta: 0.2
        )
    )
)
