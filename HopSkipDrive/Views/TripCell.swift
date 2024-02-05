import UIKit

private let kEstimatedLabelString = "est."

class TripCell: UITableViewCell {
    
    // MARK: - Properties
    
    let containerView = UIView()
    let timeAttributedLabel = UILabel()
    let ridersLabel = UILabel()
    let estimatedLabel = UILabel()
    let estimatedEarningsLabel = UILabel()
    let waypointLabel = UILabel()
    
    // MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .primaryBackgroundColor
        containerView.layer.shadowColor = .shadowColor
        containerView.layer.shadowOpacity = kContentShadowOpacity
        containerView.layer.shadowRadius = kContentShadowRadius
        containerView.layer.shadowOffset = CGSizeMake(kContentShadowOffset, kContentShadowOffset)
        containerView.clipsToBounds = false
        
        timeAttributedLabel.font = UIFont.systemFont(ofSize: kPrimaryLabelFontSize)
        timeAttributedLabel.textColor = .secondaryTextColor
        timeAttributedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ridersLabel.font = UIFont.systemFont(ofSize: kSecondaryLabelFontSize)
        ridersLabel.textColor = .secondaryTextColor
        ridersLabel.translatesAutoresizingMaskIntoConstraints = false
        
        estimatedLabel.font = UIFont.systemFont(ofSize: kSecondaryLabelFontSize)
        estimatedLabel.textColor = .primaryTextColor
        estimatedLabel.translatesAutoresizingMaskIntoConstraints = false
        estimatedLabel.text = kEstimatedLabelString
        
        estimatedEarningsLabel.font = UIFont.systemFont(ofSize: kPrimaryLabelFontSize)
        estimatedEarningsLabel.textColor = .primaryTextColor
        estimatedEarningsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        waypointLabel.font = UIFont.systemFont(ofSize: kPrimaryLabelFontSize)
        waypointLabel.textColor = .secondaryTextColor
        waypointLabel.translatesAutoresizingMaskIntoConstraints = false
        waypointLabel.numberOfLines = 0
        
        contentView.addSubview(containerView)
        containerView.addSubview(timeAttributedLabel)
        containerView.addSubview(ridersLabel)
        containerView.addSubview(estimatedEarningsLabel)
        containerView.addSubview(estimatedLabel)
        containerView.addSubview(waypointLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: kContentEdgeInset).isActive = true
        containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: kContentEdgeInset).isActive = true
        containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -kContentEdgeInset).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -kContentEdgeInset).isActive = true
        
        timeAttributedLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        timeAttributedLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: kDefaultPadding).isActive = true
        timeAttributedLabel.heightAnchor.constraint(equalToConstant: kPrimaryLabelFontSize).isActive = true
        
        ridersLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: kDefaultPadding).isActive = true
        ridersLabel.leftAnchor.constraint(equalTo: timeAttributedLabel.rightAnchor, constant: kDefaultPadding).isActive = true
        ridersLabel.bottomAnchor.constraint(equalTo: timeAttributedLabel.bottomAnchor).isActive = true
        ridersLabel.heightAnchor.constraint(equalToConstant: kSecondaryLabelFontSize).isActive = true
        
        estimatedEarningsLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: kDefaultPadding).isActive = true
        estimatedEarningsLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -kDefaultPadding).isActive = true
        estimatedEarningsLabel.heightAnchor.constraint(equalToConstant: kPrimaryLabelFontSize).isActive = true
        
        estimatedLabel.bottomAnchor.constraint(equalTo: estimatedEarningsLabel.bottomAnchor).isActive = true
        estimatedLabel.rightAnchor.constraint(equalTo: estimatedEarningsLabel.leftAnchor, constant: -kDefaultPadding).isActive = true
        estimatedLabel.heightAnchor.constraint(equalToConstant: kSecondaryLabelFontSize).isActive = true
        
        waypointLabel.topAnchor.constraint(equalTo: timeAttributedLabel.bottomAnchor, constant: kDefaultPadding).isActive = true
        waypointLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -kDefaultPadding).isActive = true
        waypointLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: kDefaultPadding).isActive = true
        waypointLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -kDefaultPadding).isActive = true
    }
    
    // MARK: - Public Methods

    public func configure(with viewModel: TripViewModel) {
        timeAttributedLabel.attributedText = viewModel.timeAttributedText
        timeAttributedLabel.accessibilityLabel = viewModel.timeAttributedText?.string
        ridersLabel.text = viewModel.ridersText
        ridersLabel.accessibilityLabel = viewModel.ridersText
        estimatedEarningsLabel.text = viewModel.estimatedEarningsText
        estimatedEarningsLabel.accessibilityLabel = viewModel.estimatedEarningsText
        waypointLabel.text = viewModel.waypointsText
        waypointLabel.accessibilityLabel = viewModel.waypointsText
        layoutSubviews()
    }

}
