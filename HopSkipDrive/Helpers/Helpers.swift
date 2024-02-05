import Foundation
import UIKit

func attributedText(withText text1: String, text2: String, fontSize: CGFloat) -> NSAttributedString {
    let attributedText = NSMutableAttributedString(string: text1, attributes: [.font : UIFont.boldSystemFont(ofSize: fontSize),
                                                                                     .foregroundColor: UIColor.gray])
    attributedText.append(NSAttributedString(string: " - \(text2)", attributes: [.font : UIFont.systemFont(ofSize: fontSize),
                                                                                 .foregroundColor: UIColor.gray]))
    return attributedText
}

func formatDate(_ value: String) -> String {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    
    let dateFormatterSet = DateFormatter()
    dateFormatterSet.amSymbol = "a"
    dateFormatterSet.pmSymbol = "p"
    dateFormatterSet.dateFormat = "h:mm a"
    
    guard let dateObj = dateFormatterGet.date(from: value) else { return "" }
    let formattedDate = dateFormatterSet.string(from: dateObj)
    return formattedDate
}

func safeAreaInsets() -> UIEdgeInsets {
    if #available(iOS 15.0, *) {
        let window = UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow}.last
        return window!.safeAreaInsets
    } else {
        let window = UIApplication.shared.windows.first
        return window!.safeAreaInsets
    }
}

func actionType(for index: Int, waypointCount: Int, anchorType: AnchorType) -> ActionType {
    if anchorType == .pickup {
        return index == 0 ? .pickup : .dropoff
    } else {
        return index == waypointCount - 1 ? .dropoff : .pickup
    }
}

func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
   let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.greatestFiniteMagnitude))
   label.numberOfLines = 0
   label.lineBreakMode = NSLineBreakMode.byWordWrapping
   label.font = font
   label.text = text

   label.sizeToFit()
   return label.frame.height
}

func widthForView(text:String, font:UIFont, height:CGFloat) -> CGFloat{
   let label:UILabel = UILabel(frame: CGRectMake(0, 0, CGFloat.greatestFiniteMagnitude, height))
   label.numberOfLines = 0
   label.lineBreakMode = NSLineBreakMode.byWordWrapping
   label.font = font
   label.text = text

   label.sizeToFit()
   return label.frame.height
}

enum PinType {
    case start
    case end
}

enum AnchorType {
    case dropoff
    case pickup
}

enum ActionType {
    case dropoff
    case pickup
}

enum MyError: Error {
    case failedToGetUrl
}

enum ButtonStyle {
    case primary
    case secondary
}
