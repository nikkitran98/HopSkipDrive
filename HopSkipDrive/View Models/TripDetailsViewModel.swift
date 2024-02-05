import Foundation

struct TripDetailsViewModel {
    var date: String
    var trip: Trip
    
    var dateText: String? {
        return date
    }
    
    var timeAttributedText: NSAttributedString? {
        return attributedText(withText: " ⋅ " + formatDate(trip.planned_route.starts_at), text2: formatDate(trip.planned_route.ends_at), fontSize: kPrimaryLabelFontSize)
    }
    
    var estimatedEarningsText: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(for: trip.estimated_earnings)
    }
    
    var isInSeries: Bool {
        if let isInSeries = trip.in_series {
            return isInSeries
        } else {
            return false
        }
    }
    
    var driveType: String? {
        return trip.time_anchor
    }
    
    var waypointsText: [String]? {
        var waypoints = [String]()
        var index = 1
        for waypoint in trip.waypoints {
            waypoints.append(String(index) + ". " + waypoint.location.address)
            index += 1
        }
        return waypoints
    }
    
    var tripDetailsText: String? {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        guard let milesString = formatter.string(for: convertToMiles(trip.planned_route.total_distance)) else { return "" }
        return "Trip ID: " + String(trip.id) + "⋅ " + milesString + " mi" + "⋅ " + String(trip.planned_route.total_time) + " min"
    }
    
    var canCancelTrip: Bool {
        return trip.driver_can_cancel
    }
    
    var startLatitude: Double {
        guard let lat = trip.waypoints.first?.location.lat else { return 0.0 }
        return lat
    }
    
    var startLongitude: Double {
        guard let lng = trip.waypoints.first?.location.lng else { return 0.0 }
        return lng
    }
    
    var endLatitude: Double {
        guard let lat = trip.waypoints.last?.location.lat else { return 0.0 }
        return lat
    }
    
    var endLongitude: Double {
        guard let lng = trip.waypoints.last?.location.lng else { return 0.0 }
        return lng
    }
    
    init(_ date: String, _ trip: Trip) {
        self.date = date
        self.trip = trip
    }
    
    fileprivate func convertToMiles(_ meters: Int) -> Double {
        return Double(meters) / 1609
    }
}
