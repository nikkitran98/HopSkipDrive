import UIKit

private let dropoffActionTypeLabelString = "Dropoff"
private let pickupActionTypeLabelString = "Pickup"

class WaypointCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let containerView = UIView()
    private let actionTypeIcon = UIImageView()
    private let actionTypeLabel = UILabel()
    private let addressLabel = UILabel()
    
    // MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .primaryBackgroundColor
        
        actionTypeIcon.tintColor = .primaryTextColor
        actionTypeIcon.clipsToBounds = true
        actionTypeIcon.translatesAutoresizingMaskIntoConstraints = false
        
        actionTypeLabel.font = UIFont.boldSystemFont(ofSize: kSecondaryLabelFontSize)
        actionTypeLabel.textColor = .secondaryTextColor
        actionTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addressLabel.font = UIFont.systemFont(ofSize: kPrimaryLabelFontSize)
        addressLabel.textColor = .secondaryTextColor
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.numberOfLines = 0
        
        addSubview(containerView)
        containerView.addSubview(actionTypeIcon)
        containerView.addSubview(actionTypeLabel)
        containerView.addSubview(addressLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        actionTypeIcon.topAnchor.constraint(equalTo: containerView.topAnchor, constant: kDefaultPadding).isActive = true
        actionTypeIcon.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: kDefaultPadding).isActive = true
        actionTypeIcon.heightAnchor.constraint(equalToConstant: kIconWidth).isActive = true
        actionTypeIcon.widthAnchor.constraint(equalToConstant: kIconWidth).isActive = true
        
        actionTypeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: kDefaultPadding).isActive = true
        actionTypeLabel.leftAnchor.constraint(equalTo: actionTypeIcon.rightAnchor, constant: kDefaultPadding).isActive = true
        actionTypeLabel.heightAnchor.constraint(equalToConstant: kSecondaryLabelFontSize).isActive = true
        
        addressLabel.topAnchor.constraint(equalTo: actionTypeLabel.bottomAnchor, constant: kDefaultPadding).isActive = true
        addressLabel.leftAnchor.constraint(equalTo: actionTypeIcon.rightAnchor, constant: kDefaultPadding).isActive = true
    }
    
    // MARK: - Public Methods
    
    public func configure(with address: String, actionType: ActionType, anchorType: AnchorType) {
        actionTypeIcon.image = anchorType.hashValue == actionType.hashValue ? .diamondImage : .circleImage
        actionTypeIcon.tintColor = .tertiaryButtonColor
        actionTypeLabel.text = actionType == .dropoff ? dropoffActionTypeLabelString : pickupActionTypeLabelString
        addressLabel.text = address
    }

}
