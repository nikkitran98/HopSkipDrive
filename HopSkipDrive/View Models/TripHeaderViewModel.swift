import Foundation

struct TripHeaderViewModel {
    var trips: [Trip]
    var date: String
    
    var dateText: String? {
        return date
    }

    var timeAttributedText: NSAttributedString? {
        var starts = [String]()
        var ends = [String]()
        for trip in trips {
            starts.append(trip.planned_route.starts_at)
            ends.append(trip.planned_route.ends_at)
        }
        return attributedText(withText: " ⋅ " + findMinimumDate(starts), text2: findMaximumDate(ends), fontSize: kSecondaryLabelFontSize)
    }
    
    var estimatedTotalEarningsText: String? {
        var earnings = 0
        for trip in trips {
            earnings += trip.estimated_earnings
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(for: earnings)
    }
    
    init(_ date: String, _ trips: [Trip]) {
        self.trips = trips
        self.date = date
    }
    
    fileprivate func findMinimumDate(_ values: [String]) -> String {
        var dates = [Date]()
        
        for value in values {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            
            guard let dateObj = dateFormatterGet.date(from: value) else { return "" }
            
            dates.append(dateObj)
        }
        
        guard let earliest = dates.min() else { return "" }
        
        let dateFormatterSet = DateFormatter()
        dateFormatterSet.dateFormat = "h:mm a"
        dateFormatterSet.amSymbol = "a"
        dateFormatterSet.pmSymbol = "p"
        
        let formattedDate = dateFormatterSet.string(from: earliest)
    
        return formattedDate
    }
    
    fileprivate func findMaximumDate(_ values: [String]) -> String {
        var dates = [Date]()
        
        for value in values {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            
            guard let dateObj = dateFormatterGet.date(from: value) else { return "" }
            
            dates.append(dateObj)
        }
        
        guard let latest = dates.max() else { return "" }
        
        let dateFormatterSet = DateFormatter()
        dateFormatterSet.dateFormat = "h:mm a"
        dateFormatterSet.amSymbol = "a"
        dateFormatterSet.pmSymbol = "p"
        
        let formattedDate = dateFormatterSet.string(from: latest)
    
        return formattedDate
    }
}
