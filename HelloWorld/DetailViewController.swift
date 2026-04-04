//
//  DetailViewController.swift
//  HelloWorld
//
//  Created by Sravan Goud on 17/03/26.
//

import UIKit
import SnapKit
import MapKit

class DetailViewController: UIViewController {
    
    private var restaurant: Restaurant?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = true
        return tableView
    }()
    
    private let tableHeaderView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let dimView: UIView = {
        let view = UIView()
        view.alpha = 0.2
        view.backgroundColor = .black
        return view
    }()
    
    private var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.alignment = .leading
        return stackView
    }()
    
    private var restaurantLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        if let customFont = UIFont(name: "Nunito-Bold", size: 40.0) {
            label.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: customFont)
        }
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    private var typeLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        if let customFont = UIFont(name: "Nunito-Bold", size: 20.0) {
            label.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: customFont)
        }
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = .black
        return label
    }()
    
    private var heartButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.hidesBarsOnSwipe = false
        
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupViews() {
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(RestaurantDetailTextCell.self, forCellReuseIdentifier: RestaurantDetailTextCell.identifier)
        tableView.register(RestaurantDetailTwoColumnCell.self, forCellReuseIdentifier: RestaurantDetailTwoColumnCell.identifier)
        tableView.register(RestaurantDetailMapCell.self, forCellReuseIdentifier: RestaurantDetailMapCell.identifier)
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 445)
        tableView.tableHeaderView = tableHeaderView
        tableHeaderView.addSubview(headerImageView)
        tableHeaderView.addSubview(dimView)
        tableHeaderView.addSubview(heartButton)
        labelStackView.addArrangedSubview(restaurantLabel)
        labelStackView.addArrangedSubview(typeLabel)
        tableHeaderView.addSubview(labelStackView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headerImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        dimView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        labelStackView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview().inset(20)
        }
        heartButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(10)
        }
    }
    
    func configure(restaurant: Restaurant) {
        self.restaurant = restaurant
        restaurantLabel.text = restaurant.name
        typeLabel.text = restaurant.type
        headerImageView.image = UIImage(named: restaurant.image)
        
        setupButtonConfig(restaurant: restaurant)
        
        // If the view is loaded, refresh the table to reflect new data
        if isViewLoaded {
            tableView.reloadData()
        }
    }
    
    func setupButtonConfig(restaurant: Restaurant) {
        var config = UIButton.Configuration.plain()
        let heartImage = restaurant.isFavorite ? "heart.fill" : "heart"
        let pointSize: CGFloat = 30.0 // Adjust the size as needed
        let imageConfig = UIImage.SymbolConfiguration(pointSize: pointSize)
        let image = UIImage(systemName: heartImage, withConfiguration: imageConfig)
        config.image = image
        config.baseForegroundColor = restaurant.isFavorite ? .systemYellow : .white
        config.contentInsets = .zero
        heartButton.configuration = config
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantDetailTextCell.identifier, for: indexPath) as! RestaurantDetailTextCell
            cell.configure(with: restaurant?.description)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantDetailTwoColumnCell.identifier, for: indexPath) as! RestaurantDetailTwoColumnCell
            cell.configure(with: restaurant)
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantDetailMapCell.identifier, for: indexPath) as! RestaurantDetailMapCell
            cell.configure(with: restaurant)
            cell.selectionStyle = .none
            return cell
        default:
            fatalError("Unhandled Row")
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 445
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return tableHeaderView
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.row == 2 else { return }
        let detailMapViewController = DetailMapViewController(restaurant: restaurant)
        navigationController?.pushViewController(detailMapViewController, animated: true)
    }
}

class RestaurantDetailTextCell: UITableViewCell {
    
    static let identifier = "RestaurantDetailTextCell"
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView.layoutMarginsGuide)
        }
    }
    
    func configure(with description: String?) {
        descriptionLabel.text = description
    }
    
}

class RestaurantDetailTwoColumnCell: UITableViewCell {
    
    static let identifier = "RestaurantDetailTwoColumnCell"
    
    private var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private var addressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()
    
    private var phoneStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()
    
    private var addressTitleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.text = "Address"
        label.numberOfLines = 0
        return label
    }()
    
    private var addressLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.text = "Full Address"
        label.numberOfLines = 0
        return label
    }()
    
    private var phoneTitleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.text = "Phone"
        label.numberOfLines = 0
        return label
    }()
    
    private var phoneLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.text = "Phone Number"
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addressStackView.addArrangedSubview(addressTitleLabel)
        addressStackView.addArrangedSubview(addressLabel)
        phoneStackView.addArrangedSubview(phoneTitleLabel)
        phoneStackView.addArrangedSubview(phoneLabel)
        containerStackView.addArrangedSubview(addressStackView)
        containerStackView.addArrangedSubview(phoneStackView)
        contentView.addSubview(containerStackView)
    }
    
    func setupConstraints() {
        containerStackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.layoutMarginsGuide)
        }
    }
    
    func configure(with restaurant: Restaurant?) {
        addressLabel.text = restaurant?.fullAddress
        phoneLabel.text = restaurant?.phone
    }
    
}

class RestaurantDetailMapCell: UITableViewCell {
    static let identifier = "RestaurantDetailMapCell"
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        mapView.layer.cornerRadius = 20
        mapView.clipsToBounds = true
        contentView.addSubview(mapView)
    }
    
    func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(10)
            make.height.equalTo(200)
        }
    }
    
    func configure(with restaurant: Restaurant?) {
        guard let query = restaurant?.location, !query.isEmpty else { return }

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query

        // If you have a general region to bias results, you can set it here; otherwise, use the current map visible region
        request.region = mapView.region

        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let self = self else { return }
            // Clear existing annotations
            self.mapView.removeAnnotations(self.mapView.annotations)

            guard error == nil, let mapItem = response?.mapItems.first else { return }

            let coordinate = mapItem.location.coordinate
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
//            annotation.title = restaurant?.name

            self.mapView.addAnnotation(annotation)

            // Zoom to a reasonable region around the found coordinate
//            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//            let region = MKCoordinateRegion(center: coordinate, span: span)
//            self.mapView.setRegion(region, animated: true)
            
            let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
            self.mapView.setRegion(region, animated: false)
        }
    }
}
