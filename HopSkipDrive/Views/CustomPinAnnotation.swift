import MapKit
import UIKit

class CustomPinAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let type: PinType
    
    init(type: PinType, coordinate: CLLocationCoordinate2D) {
        self.type = type
        self.coordinate = coordinate
        
        super.init()
    }
}
