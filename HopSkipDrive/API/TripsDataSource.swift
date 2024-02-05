import Foundation

class TripsDataSource {
    private var APIService: APIService
    
    var trips = [String: [Trip]]()
    var sections = [String]()
    
    init(withAPIService APIService: APIService) {
        self.APIService = APIService
    }
    
    func fetchTrips() async {
        let result = await self.APIService.fetchTrips()
        switch result {
        case .success(let trips):
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            
            let dateFormatterSet = DateFormatter()
            dateFormatterSet.dateFormat = "E, MM/dd"
            
            for trip in trips {
                guard let waypoint = trip.waypoints.first else { return }
                guard let dateObj = dateFormatterGet.date(from: waypoint.estimated_arrives_at) else { return }
                let formattedDate = dateFormatterSet.string(from: dateObj)
                if self.trips[formattedDate] != nil {
                    self.trips[formattedDate]?.append(trip)
                } else {
                    self.trips[formattedDate] = [trip]
                    self.sections.append(formattedDate)
                }
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}
