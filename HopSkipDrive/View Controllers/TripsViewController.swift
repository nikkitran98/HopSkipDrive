import UIKit

private let kNavigationTitleString = "My Rides"
private let kTripCellReuseIdentifier = "trip-cell"
private let kTripHeaderReuseIdentifier = "trip-header"
private let kTableViewRowHeight: CGFloat = 125.0
private let kTableViewHeaderHeight: CGFloat = 40.0

class TripsViewController: UIViewController {
    
    // MARK: - Properties
    
    private var APIService: APIService
    private var dataSource: TripsDataSource
    private let tableView = UITableView()
    
    // MARK: - Life Cycle
    
    init(_ APIService: APIService) {
        self.APIService = APIService
        self.dataSource = TripsDataSource(withAPIService: APIService)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .hamburgerImage, style: .plain, target: self, action: #selector(didTapHamburgerMenu))
        navigationItem.leftBarButtonItem?.tintColor = .navigationBarButtonColor
        navigationController?.navigationBar.backgroundColor = .secondaryButtonColor
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .primaryTextColor
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.navigationBarButtonColor]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        view.backgroundColor = .primaryBackgroundColor
        
        fetchTrips()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = kTableViewRowHeight
        tableView.sectionHeaderHeight = kTableViewHeaderHeight
        tableView.separatorStyle = .none
        tableView.register(TripCell.self, forCellReuseIdentifier: kTripCellReuseIdentifier)
        tableView.register(TripHeaderView.self, forHeaderFooterViewReuseIdentifier: kTripHeaderReuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = kNavigationTitleString
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // MARK: - Helpers
    
    @objc private func didTapHamburgerMenu() {
        // NO-OP
    }
    
    private func fetchTrips() {
        Task {
            await self.dataSource.fetchTrips()
            await MainActor.run {
                self.tableView.reloadData()
            }
        }
    }

}

// MARK: - UITableViewDelegate/UITableViewDataSource

extension TripsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTripCellReuseIdentifier, for: indexPath) as! TripCell
        guard let trips = dataSource.trips[dataSource.sections[indexPath.section]] else { return cell }
        let trip = trips[indexPath.row]
        cell.configure(with: TripViewModel(trip))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.trips[dataSource.sections[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let trips = dataSource.trips[dataSource.sections[indexPath.section]] else { return }
        let trip = trips[indexPath.row]
        navigationController?.pushViewController(TripDetailsViewController(withViewModel: TripDetailsViewModel(dataSource.sections[indexPath.section], trip)), animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.trips.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: kTripHeaderReuseIdentifier) as! TripHeaderView
        guard let trips = dataSource.trips[dataSource.sections[section]] else { return nil }
        header.configure(with: TripHeaderViewModel(dataSource.sections[section], trips))
        return header
    }
}
