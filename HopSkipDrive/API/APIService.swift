import Foundation

class APIService {
    static let shared = APIService()
    
    func fetchTrips() async -> Result<[Trip], Error> {
        guard let url = URL(string: URL_STRING) else { return .failure(MyError.failedToGetUrl) }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let jsonResult = try JSONDecoder().decode(TripResponse.self, from: data)
            let trips = jsonResult.trips
            return .success(trips)
        } catch {
            print(error.localizedDescription)
            return .failure(error)
        }
    }
}
