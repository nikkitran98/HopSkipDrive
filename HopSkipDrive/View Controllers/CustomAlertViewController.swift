import UIKit

private let kAlertViewButtonHeight: CGFloat = 40.0
private let kCancelButtonHeight: CGFloat = 16.0
private let kContainerWidth: CGFloat = 300.0
private let kContainerViewCornerRadius: CGFloat = 20.0
private let kLargePadding: CGFloat = 20.0
private let kSmallPadding: CGFloat = 10.0
private let kTitleLabelHeight: CGFloat = 20.0

class CustomAlertViewController: UIViewController {
    
    // MARK: - Properties
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private var buttons = [UIButton]()
    private let cancelButton = UIButton()
    
    // MARK: - Life Cycle
    
    init(title: String, description: String, buttonStrings: String..., buttonStyles: ButtonStyle...) {
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = title
        descriptionLabel.text = description
        
        for index in 0..<buttonStrings.count {
            let buttonString = buttonStrings[index]
            let buttonStyle = buttonStyles[index]
            let button = initializeButton(buttonString, buttonStyle)
            buttons.append(button)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .primaryBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = kContainerViewCornerRadius
        view.clipsToBounds = false
        view.layer.shadowColor = .shadowColor
        view.layer.shadowOpacity = kContentShadowOpacity
        view.layer.shadowRadius = kContentShadowRadius
        view.layer.shadowOffset = CGSizeMake(kContentShadowOffset, kContentShadowOffset)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: kLargeTitleFontSize)
        titleLabel.textColor = .black
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: kPrimaryLabelFontSize)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0
        
        cancelButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        cancelButton.tintColor = .primaryButtonColor
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        view.addSubview(containerView)
        containerView.addSubview(cancelButton)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        for button in self.buttons {
            containerView.addSubview(button)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
        let descriptionLabelHeight: CGFloat = heightForView(text: descriptionLabel.text!, font: descriptionLabel.font, width: kContainerWidth-20)
        
        let containerHeight: CGFloat = kCancelButtonHeight + kTitleLabelHeight + descriptionLabelHeight + (kAlertViewButtonHeight * CGFloat(buttons.count)) + 40.0
        
        view.centerXAnchor.constraint(equalTo: view.superview!.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: view.superview!.centerYAnchor).isActive = true
        view.heightAnchor.constraint(equalToConstant: containerHeight).isActive = true
        view.widthAnchor.constraint(equalToConstant: kContainerWidth).isActive = true
        
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: containerHeight).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: kContainerWidth).isActive = true

        cancelButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: kSmallPadding).isActive = true
        cancelButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -kSmallPadding).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: kCancelButtonHeight).isActive = true

        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: kLargePadding).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: kTitleLabelHeight).isActive = true

        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: kDefaultPadding).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: kSmallPadding).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -kSmallPadding).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: descriptionLabelHeight).isActive = true
        
        var previousLabelAnchor = descriptionLabel.bottomAnchor
        
        for button in self.buttons {
            button.topAnchor.constraint(equalTo: previousLabelAnchor, constant: kDefaultPadding).isActive = true
            button.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: kLargePadding).isActive = true
            button.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -kLargePadding).isActive = true
            button.heightAnchor.constraint(equalToConstant: kAlertViewButtonHeight).isActive = true
            previousLabelAnchor = button.bottomAnchor
        }
    }
    
    // MARK: - Helpers
    
    private func initializeButton(_ string: String, _ style: ButtonStyle) -> UIButton {
        let button = UIButton()
        button.setTitle(string, for: .normal)
        button.setTitleColor(style == .primary ? .tertiaryTextColor : .primaryTextColor, for: .normal)
        button.backgroundColor = style == .primary ? .primaryButtonColor : .secondaryButtonColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = kAlertViewButtonHeight / 2
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }
    
    @objc private func didTapButton() {
        self.dismiss(animated: true)
    }

}
