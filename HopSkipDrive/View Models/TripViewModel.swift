import Foundation
import UIKit

struct TripViewModel {
    
    private let trip: Trip
    
    var timeAttributedText: NSAttributedString? {
        return attributedText(withText: formatDate(trip.planned_route.starts_at), text2: formatDate(trip.planned_route.ends_at), fontSize: kPrimaryLabelFontSize)
    }
    
    var ridersText: String? {
        var ridersString = "("
        var count = 0
        if trip.passengers.count == 1 {
            ridersString += "1 rider"
        } else {
            ridersString += String(trip.passengers.count) + " riders"
        }
        for passenger in trip.passengers {

            if passenger.booster_seat {
                count += 1
            }
        }
        if count == 1 {
            ridersString += "⋅1 booster"
        } else if count > 1 {
            ridersString += "⋅" + String(count) + " boosters"
        }
        ridersString += ")"
        return ridersString
    }
    
    var estimatedEarningsText: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(for: trip.estimated_earnings)
    }
    
    var waypointsText: String? {
        var waypoints = ""
        var index = 1
        for waypoint in trip.waypoints {
            waypoints += String(index) + ". " + waypoint.location.address + "\n"
            index += 1
        }
        return waypoints
    }
    
    init(_ trip: Trip) {
        self.trip = trip
    }
    
    fileprivate func waypointText(withIndex index: Int, address: String) -> String {
        return String(index) + address
    }
    
}
