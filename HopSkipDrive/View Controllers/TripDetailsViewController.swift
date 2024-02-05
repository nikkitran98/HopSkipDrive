import MapKit
import UIKit

private let kAlertDescriptionString = "Are you sure you want to cancel this claim? This cannot be undone."
private let kAlertTitleString = "Are you sure?"
private let kAnnotationViewReuseIdentifier = "annotation-view"
private let kCancelButtonString = "Cancel this trip"
private let kEstimatedLabelString = "ESTIMATED"
private let kIsInSeriesLabelString = "This trip is part of a series."
private let kMapViewHeight = 210.0
private let kNavigationTitleString = "Ride Details"
private let kPadding: CGFloat = 10.0
private let kPrimaryButtonString = "Nevermind"
private let kRoundedViewHeight: CGFloat = 20.0
private let kRoundedViewWidth: CGFloat = 80.0
private let kSecondaryButtonString = "Yes"
private let kTableViewHeight = 200.0
private let kTableViewRowHeight = 50.0
private let kWaypointCellReuseIdentifier = "waypoint-cell"

class TripDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: TripDetailsViewModel
    private let dateLabel = UILabel()
    private let timeLabel = UILabel()
    private let estimatedLabel = UILabel()
    private let estimatedEarningsRoundedView = UIView()
    private let estimatedEarningsLabel = UILabel()
    private let mapView = MKMapView()
    private let inSeriesLabel = UILabel()
    private let tableView = UITableView()
    private let tripDetailsLabel = UILabel()
    private let cancelButton = UIButton()
    
    // MARK: - Life Cycle
    
    init(withViewModel viewModel: TripDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .primaryBackgroundColor

        navigationController?.navigationBar.tintColor = .primaryBackgroundColor
        navigationController?.navigationBar.topItem?.title = ""
        navigationItem.title = kNavigationTitleString
        
        dateLabel.font = UIFont.boldSystemFont(ofSize: kPrimaryLabelFontSize)
        dateLabel.textColor = .primaryTextColor
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        timeLabel.textColor = .secondaryTextColor
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        estimatedLabel.font = UIFont.systemFont(ofSize: kSecondaryLabelFontSize)
        estimatedLabel.textColor = .secondaryTextColor
        estimatedLabel.translatesAutoresizingMaskIntoConstraints = false
        estimatedLabel.text = kEstimatedLabelString
        
        estimatedEarningsRoundedView.backgroundColor = .tertiaryButtonColor
        estimatedEarningsRoundedView.clipsToBounds = true
        estimatedEarningsRoundedView.layer.cornerRadius = kCornerRadius
        estimatedEarningsRoundedView.translatesAutoresizingMaskIntoConstraints = false
        
        estimatedEarningsLabel.font = UIFont.systemFont(ofSize: kPrimaryLabelFontSize)
        estimatedEarningsLabel.textColor = .tertiaryTextColor
        estimatedEarningsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        inSeriesLabel.font = UIFont.italicSystemFont(ofSize: kSecondaryLabelFontSize)
        inSeriesLabel.textColor = .secondaryTextColor
        inSeriesLabel.text = kIsInSeriesLabelString
        inSeriesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WaypointCell.self, forCellReuseIdentifier: kWaypointCellReuseIdentifier)
        tableView.rowHeight = kTableViewRowHeight
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tripDetailsLabel.font = UIFont.systemFont(ofSize: kSecondaryLabelFontSize)
        tripDetailsLabel.textColor = .secondaryTextColor
        tripDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cancelButton.setTitle(kCancelButtonString, for: .normal)
        cancelButton.setTitleColor(.alertStyleButtonColor, for: .normal)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        
        estimatedEarningsRoundedView.addSubview(estimatedEarningsLabel)
        view.addSubview(dateLabel)
        view.addSubview(timeLabel)
        view.addSubview(estimatedLabel)
        view.addSubview(estimatedEarningsRoundedView)
        view.addSubview(mapView)
        view.addSubview(tableView)
        view.addSubview(inSeriesLabel)
        view.addSubview(tripDetailsLabel)
        view.addSubview(cancelButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top + kDefaultPadding).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: kDefaultPadding).isActive = true
        
        timeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top + kDefaultPadding).isActive = true
        timeLabel.leftAnchor.constraint(equalTo: dateLabel.rightAnchor).isActive = true
        
        estimatedLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top + kDefaultPadding).isActive = true
        estimatedLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -kPadding).isActive = true

        estimatedEarningsRoundedView.topAnchor.constraint(equalTo: estimatedLabel.bottomAnchor, constant: kDefaultPadding).isActive = true
        estimatedEarningsRoundedView.centerXAnchor.constraint(equalTo: estimatedLabel.centerXAnchor).isActive = true
        estimatedEarningsRoundedView.widthAnchor.constraint(equalToConstant: kRoundedViewWidth).isActive = true
        estimatedEarningsRoundedView.heightAnchor.constraint(equalToConstant: kRoundedViewHeight).isActive = true
        
        estimatedEarningsLabel.centerXAnchor.constraint(equalTo: estimatedEarningsRoundedView.centerXAnchor).isActive = true
        estimatedEarningsLabel.centerYAnchor.constraint(equalTo: estimatedEarningsRoundedView.centerYAnchor).isActive = true
        
        mapView.topAnchor.constraint(equalTo: estimatedEarningsLabel.bottomAnchor, constant: kDefaultPadding).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: kMapViewHeight).isActive = true
        mapView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        inSeriesLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 10.0).isActive = true
        inSeriesLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10.0).isActive = true
        inSeriesLabel.heightAnchor.constraint(equalToConstant: kSecondaryLabelFontSize).isActive = true
        
        let previousBottomAnchor = inSeriesLabel.isHidden ? mapView.bottomAnchor : inSeriesLabel.bottomAnchor
        tableView.topAnchor.constraint(equalTo: previousBottomAnchor, constant: kDefaultPadding).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: tableView.contentSize.height).isActive = true
        
        tripDetailsLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 15.0).isActive = true
        tripDetailsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15.0).isActive = true
        tripDetailsLabel.heightAnchor.constraint(equalToConstant: kSecondaryLabelFontSize).isActive = true
        
        cancelButton.topAnchor.constraint(equalTo: tripDetailsLabel.bottomAnchor, constant: 15.0).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: kButtonHeight).isActive = true
        cancelButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    // MARK: - Helpers
    
    private func configure() {
        dateLabel.text = viewModel.dateText
        timeLabel.attributedText = viewModel.timeAttributedText
        estimatedEarningsLabel.text = viewModel.estimatedEarningsText
        let startPin = CustomPinAnnotation(type: .start, coordinate: CLLocationCoordinate2D(latitude: viewModel.startLatitude, longitude: viewModel.startLongitude))
        let endPin = CustomPinAnnotation(type: .end, coordinate: CLLocationCoordinate2D(latitude: viewModel.endLatitude, longitude: viewModel.endLongitude))
        mapView.addAnnotations([startPin, endPin])
        mapView.showAnnotations(mapView.annotations, animated: true)
        mapView.fitAll()
        inSeriesLabel.isHidden = !viewModel.isInSeries
        tripDetailsLabel.text = viewModel.tripDetailsText
        cancelButton.isHidden = !viewModel.canCancelTrip
    }
    
    @objc private func didTapCancelButton() {
        let alertView = CustomAlertViewController(title: kAlertTitleString, description: kAlertDescriptionString, buttonStrings: kPrimaryButtonString, kSecondaryButtonString, buttonStyles: .primary, .secondary)
        alertView.modalPresentationStyle = .overFullScreen
        alertView.modalTransitionStyle = .crossDissolve
        self.present(alertView, animated: true)
    }

}

// MARK: - UITableViewDelegate/UITableViewDataSource

extension TripDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kWaypointCellReuseIdentifier) as! WaypointCell
        let anchorType: AnchorType = viewModel.trip.time_anchor == "pick_up" ? .pickup : .dropoff
        let actionType = actionType(for: indexPath.row, waypointCount: viewModel.trip.waypoints.count, anchorType: anchorType)
        cell.configure(with: viewModel.trip.waypoints[indexPath.row].location.address, actionType: actionType, anchorType: anchorType)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.trip.waypoints.count
    }
}

// MARK: - MKMapViewDelegate

extension TripDetailsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? CustomPinAnnotation else { return nil }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: kAnnotationViewReuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: kAnnotationViewReuseIdentifier)
        } else {
            annotationView?.annotation = annotation
        }

        let circleImage = UIImage.circleImage?.withRenderingMode(.alwaysTemplate)
        annotationView?.image = annotation.type == .start ? circleImage?.colorized(color: .startPinColor) : circleImage?.colorized(color: .endPinColor)
        
        return annotationView
    }
}
