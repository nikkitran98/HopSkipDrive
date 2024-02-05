import MapKit
import UIKit

extension UIColor {
    static let primaryTextColor = UIColor(red: 0.00, green: 0.18, blue: 0.54, alpha: 1.00)
    static let secondaryTextColor = UIColor.gray
    static let tertiaryTextColor = UIColor.white
    static let primaryButtonColor = UIColor(red: 0.00, green: 0.18, blue: 0.54, alpha: 1.00)
    static let secondaryButtonColor = UIColor.white
    static let tertiaryButtonColor = UIColor(red: 0.29, green: 0.71, blue: 0.98, alpha: 1.00)
    static let primaryBackgroundColor = UIColor.white
    static let alertStyleButtonColor = UIColor.red
    static let navigationBarButtonColor = UIColor.white
    static let navigationBarTitleColor = UIColor.white
    static let startPinColor = UIColor.green
    static let endPinColor = UIColor.red
}

extension CGColor {
    static let shadowColor = UIColor.black.cgColor
    static let separatorViewColor = UIColor.gray.cgColor
}

extension UIImage {
    static let hamburgerImage = UIImage(systemName: "line.3.horizontal")
    static let diamondImage = UIImage(systemName: "diamond.fill")
    static let circleImage = UIImage(systemName: "circle.fill")
    
    func colorized(color : UIColor) -> UIImage {
        let rect = CGRectMake(0.0, 0.0, self.size.width, self.size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        context.setBlendMode(.copy)
        context.draw(self.cgImage!, in: rect)
        context.clip(to: rect, mask: self.cgImage!)
        context.setFillColor(color.cgColor)
        context.fill(rect)
        guard let colorizedImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        return colorizedImage
    }
}

extension MKMapView {
    func fitAll() {
        var zoomRect            = MKMapRect.null;
        for annotation in annotations {
            let annotationPoint = MKMapPoint(annotation.coordinate)
            let pointRect       = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.01, height: 0.01);
            zoomRect            = zoomRect.union(pointRect);
        }
        setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 100.0, left: 100.0, bottom: 100.0, right: 100.0), animated: true)
    }
}
