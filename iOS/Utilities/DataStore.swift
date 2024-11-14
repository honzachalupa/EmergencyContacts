import SwiftData
import CoreLocation

class DataStore: ObservableObject {
    @Published var data: [DataItem]!
    @Published var dataGrouped: [DataItem.CategoryType: [DataItem]];
    @Published var errorMessage: String!
    
    let url = "https://www.nouzovekontakty.cz/api/json"
    
    init() {
        self.data = []
        self.dataGrouped = [:];
        self.errorMessage = nil
        
        self.fetch(url) { (fetcherResult: Result<Data?, Error>) in
            switch fetcherResult {
                case .success(let fetchedData):
                    if let data = fetchedData {
                        self.decode(data) { (decoderResult: Result<[DataItem], Error>) in
                            switch decoderResult {
                                case .success(let parsedData):
                                    let sortedData = self.sortData(parsedData);
                                    
                                    self.data = sortedData
                                    self.dataGrouped = groupByCategory(sortedData)
                                case .failure(let error):
                                    debugPrint(error)
                                    
                                    self.errorMessage = "Failed to fetch data: \(error.localizedDescription)"
                            }
                        }
                    }
                case .failure(let error):
                    debugPrint(error)
                    
                    self.errorMessage = "Failed to fetch data: \(error.localizedDescription)"
            }
        }
    }
    
    func fetch(_ url: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        /* guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"] else {
         print("Error: API_KEY not found")
         return
         } */
        
        guard let url = URL(string: url) else {
            completion(
                .failure(
                    NSError(
                        domain: "DataManager",
                        code: 0,
                        userInfo: [
                            NSLocalizedDescriptionKey: "Invalid URL"
                        ]
                    )
                )
            )
            
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    if let httpResponse = response as? HTTPURLResponse {
                        completion(
                            .failure(
                                NSError(
                                    domain: "DataManager",
                                    code: httpResponse.statusCode,
                                    userInfo: [
                                        NSLocalizedDescriptionKey: "Error with the response, unexpected status code: \(httpResponse.statusCode)"
                                    ]
                                )
                            )
                        )
                    } else {
                        completion(
                            .failure(
                                NSError(
                                    domain: "DataManager",
                                    code: 0,
                                    userInfo: [
                                        NSLocalizedDescriptionKey: "Error with the response, unexpected status code"
                                    ]
                                )
                            )
                        )
                    }
                }
                return
            }
            
            completion(.success(data))
            return
        }.resume()
    }

    func decode<T: Decodable>(_ raw: Data, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let decoded = try JSONDecoder().decode(T.self, from: raw)
            
            DispatchQueue.main.async {
                completion(
                    .success(decoded)
                )
            }
        } catch {
            DispatchQueue.main.async {
                completion(
                    .failure(error)
                )
            }
        }
    }
    
    func sortData(_ data: [DataItem]) -> [DataItem] {
        let locationManager = CLLocationManager()
        let currentCoordinates = locationManager.location?.coordinate
        
        if let unwrappedCoordinates = currentCoordinates {
            let currentLocation = CLLocation(latitude: unwrappedCoordinates.latitude, longitude: unwrappedCoordinates.longitude)
            
            var sorted = data.map {
                let location = CLLocation(latitude: $0.coordinates.latitude, longitude: $0.coordinates.longitude)
                let distance = currentLocation.distance(from: location) / 1000;
                
                // print(item1.name, distanceA)
                
                var item = $0
                item.distance = distance
                
                return item
            }
            
            print(sorted)
            
            sorted.sort {
                return $0.distance! < $1.distance!
            }
            
            return sorted
        }
        
        return data;
    }
}
