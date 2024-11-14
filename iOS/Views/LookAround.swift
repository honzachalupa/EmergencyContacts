import SwiftUI
import MapKit

struct LookAroundPreview: UIViewControllerRepresentable {
    typealias UIViewControllerType = MKLookAroundViewController
    
    @State var coordinates: CLLocationCoordinate2D?
    
    func makeUIViewController(context: Context) -> MKLookAroundViewController {
        return MKLookAroundViewController()
    }
    
    func updateUIViewController(_ uiViewController: MKLookAroundViewController, context: Context) {
        Task {
            let scene = await getScene(location: coordinates)

            uiViewController.scene = scene
        }
    }
    
    func getScene(location: CLLocationCoordinate2D?) async -> MKLookAroundScene? {
        if let latitude = coordinates?.latitude, let longitude = coordinates?.longitude {
            let sceneRequest = MKLookAroundSceneRequest(coordinate: .init(latitude: latitude, longitude: longitude))

            do {
                return try await sceneRequest.scene
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
}

#Preview {
    LookAroundPreview(coordinates: mockedItems.first!.coordinates)
}
