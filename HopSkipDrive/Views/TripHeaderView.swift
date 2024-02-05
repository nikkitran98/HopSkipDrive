import UIKit

private let kEstimatedLabelString = "ESTIMATED"
private let kPadding: CGFloat = 10.0
private let kSeparatorViewAlpha: CGFloat = 0.3
private let kSeparatorViewWidth: CGFloat = 1.0
private let kStackViewHeight: CGFloat = 30.0

class TripHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    
    private let dateLabel = UILabel()
    private let timeLabel = UILabel()
    private let estimatedLabel = UILabel()
    private let estimatedTotalEarningsLabel = UILabel()
    private let separatorView = UIView()
    private let estimatedEarningsStackView: UIStackView
    
    // MARK: - Life Cycle

    override init(reuseIdentifier: String?) {
        estimatedEarningsStackView = UIStackView(arrangedSubviews: [estimatedLabel, estimatedTotalEarningsLabel])
        super.init(reuseIdentifier: reuseIdentifier)
        
        dateLabel.font = UIFont.boldSystemFont(ofSize: kPrimaryLabelFontSize)
        dateLabel.textColor = .primaryTextColor
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        timeLabel.textColor = .secondaryTextColor
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        estimatedLabel.font = UIFont.systemFont(ofSize: kPrimaryLabelFontSize)
        estimatedLabel.textColor = .secondaryTextColor
        estimatedLabel.translatesAutoresizingMaskIntoConstraints = false
        estimatedLabel.text = kEstimatedLabelString
        
        estimatedTotalEarningsLabel.font = UIFont.systemFont(ofSize: kPrimaryLabelFontSize)
        estimatedTotalEarningsLabel.textColor = .primaryTextColor
        estimatedTotalEarningsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        separatorView.layer.borderColor = .separatorViewColor
        separatorView.layer.borderWidth = kSeparatorViewWidth
        separatorView.alpha = kSeparatorViewAlpha
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        estimatedEarningsStackView.axis = .vertical
        estimatedEarningsStackView.distribution = .fillProportionally
        estimatedEarningsStackView.translatesAutoresizingMaskIntoConstraints = false
        estimatedEarningsStackView.alignment = .center
        
        addSubview(dateLabel)
        addSubview(timeLabel)
        addSubview(estimatedEarningsStackView)
        addSubview(separatorView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: kPadding).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: kPrimaryLabelFontSize).isActive = true
        
        timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        timeLabel.leftAnchor.constraint(equalTo: dateLabel.rightAnchor).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: kPrimaryLabelFontSize).isActive = true
        
        estimatedEarningsStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: kDefaultPadding).isActive = true
        estimatedEarningsStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -kPadding).isActive = true
        estimatedEarningsStackView.heightAnchor.constraint(equalToConstant: kStackViewHeight).isActive = true
        
        separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: kSeparatorViewWidth).isActive = true
    }
    
    // MARK: - Public Methods
    
    public func configure(with viewModel: TripHeaderViewModel) {
        dateLabel.text = viewModel.dateText
        timeLabel.attributedText = viewModel.timeAttributedText
        estimatedTotalEarningsLabel.text = viewModel.estimatedTotalEarningsText
    }

}
