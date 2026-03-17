//
//  RestaurantViewController.swift
//  HelloWorld
//
//  Created by Sravan on 15/03/26.
//

import UIKit
import SnapKit

nonisolated struct Restaurant: Hashable {
    let name: String
    let type: String
    let location: String
    let image: String
    var isFavorite: Bool = false
}

class CustomCell: UITableViewCell {
    
    static let identifier = "CustomCell"
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 20
        stack.axis = .horizontal
        stack.alignment = .top
        return stack
    }()
    
    private var restaurantImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let labelStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 4
        stack.axis = .vertical
        return stack
    }()
    
    private var restaurantLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Location"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private var typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Type"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .systemGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        tintColor = .systemYellow
//        preservesSuperviewLayoutMargins = false
//        contentView.preservesSuperviewLayoutMargins = false
//        layoutMargins = .zero
//        contentView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
//        separatorInset = .zero
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        labelStackView.addArrangedSubview(restaurantLabel)
        labelStackView.addArrangedSubview(locationLabel)
        labelStackView.addArrangedSubview(typeLabel)
        containerStackView.addArrangedSubview(restaurantImage)
        containerStackView.addArrangedSubview(labelStackView)
        contentView.addSubview(containerStackView)
    }
    
    private func setupConstraints() {
        containerStackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.layoutMarginsGuide)
        }
        restaurantImage.snp.makeConstraints { make in
            make.width.height.equalTo(120)
        }
    }
    
    func configure(restaurant: Restaurant) {
        restaurantLabel.text = restaurant.name
        locationLabel.text = restaurant.location
        typeLabel.text = restaurant.type
        restaurantImage.image = UIImage(named: restaurant.image)
    }
}

class CustomCellFinal: UITableViewCell {
    
    static let identifier = "CustomCellFinal"
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 5
        stack.axis = .vertical
        stack.alignment = .fill
        return stack
    }()
    
    private var restaurantImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let labelStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 4
        stack.axis = .vertical
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 0,
            leading: 20,
            bottom: 0,
            trailing: 20
        )
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    private var restaurantLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Location"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private var typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Type"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .systemGray
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
    
    private func setupViews() {
        labelStackView.addArrangedSubview(restaurantLabel)
        labelStackView.addArrangedSubview(locationLabel)
        labelStackView.addArrangedSubview(typeLabel)
        containerStackView.addArrangedSubview(restaurantImage)
        containerStackView.addArrangedSubview(labelStackView)
        contentView.addSubview(containerStackView)
    }
    
    private func setupConstraints() {
        containerStackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.layoutMarginsGuide).inset(20)
        }
        restaurantImage.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
    }
    
    func configure(restaurant: Restaurant) {
        restaurantLabel.text = restaurant.name
        locationLabel.text = restaurant.location
        typeLabel.text = restaurant.type
        restaurantImage.image = UIImage(named: restaurant.image)
    }
}


class RestaurantViewController: UIViewController {
    
    private var restaurants: [Restaurant] = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", image: "cafedeadend", isFavorite: false),
        Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image: "homei", isFavorite: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha", isFavorite: false),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", image: "cafeloisl", isFavorite: false),
        Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong", image: "petiteoyster", isFavorite: false),
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", image: "forkee", isFavorite: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", image: "posatelier", isFavorite: false),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", image: "bourkestreetbakery", isFavorite: false),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", image: "haigh", isFavorite: false),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", image: "palomino", isFavorite: false),
        Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate", isFavorite: false),
        Restaurant(name: "Traif", type: "American", location: "New York", image: "traif", isFavorite: false),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "graham", isFavorite: false),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", image: "waffleandwolf", isFavorite: false),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", image: "fiveleaves", isFavorite: false),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", image: "cafelore", isFavorite: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "New York", image: "confessional", isFavorite: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina", isFavorite: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia", isFavorite: false),
        Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak", isFavorite: false),
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", image: "cask", isFavorite: false)
    ]
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Restaurant>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>
    
    var dataSource: DataSource!
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let restaurant = self.restaurants[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
            cell.configure(restaurant: restaurant)
            cell.accessoryType = restaurant.isFavorite ? .checkmark : .none
            return cell
        }
    }
    
    private func applySnapshot(data: [Restaurant], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    override var prefersStatusBarHidden: Bool {
        true
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "FoodPin"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupViews()
        setupConstraints()
        configureDataSource()
        applySnapshot(data: restaurants)
    }
    
    private func setupViews() {
//        tableView.rowHeight = 140
        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 140
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        tableView.register(CustomCellFinal.self, forCellReuseIdentifier: CustomCellFinal.identifier)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension RestaurantViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        optionMenu.addAction(cancelAction)
//        
//        if let popover = optionMenu.popoverPresentationController {
//            if let cell = tableView.cellForRow(at: indexPath) {
//                popover.sourceView = cell
//                popover.sourceRect = cell.bounds
//            }
//        }
//        
//        let reserveActionHandler = { (action: UIAlertAction) -> Void in
//            let alertMessage = UIAlertController(title: "Not available yet", message: "Sorry, this feature is not available yet. Please retry later.", preferredStyle: .alert)
//            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alertMessage, animated: true)
//        }
//        
//        let reserveAction = UIAlertAction(title: "Reserve a table", style: .default, handler: reserveActionHandler)
//        
//        optionMenu.addAction(reserveAction)
//        
//        let favoriteAction = UIAlertAction(title: "Mark as favorite", style: .default) { action in
//            let cell = tableView.cellForRow(at: indexPath)
//            cell?.accessoryType = .checkmark
//            self.restaurants[indexPath.row].isFavorite = true
//        }
//        
//        optionMenu.addAction(favoriteAction)
//        
//        present(optionMenu, animated: true)
        
        let detailVC = DetailViewController()
        detailVC.configure(restaurant: restaurants[indexPath.row])
        
        navigationController?.pushViewController(detailVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension RestaurantViewController {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems([restaurant])
            self.dataSource.apply(snapshot)
            completionHandler(true)
        }
        
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, view, completionHandler) in
            let activityViewController = UIActivityViewController(activityItems: ["Check out this restaurant!"], applicationActivities: nil)
            self.present(activityViewController, animated: true)
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .red
        deleteAction.image = UIImage(systemName: "trash")
        
        shareAction.backgroundColor = .systemBlue
        shareAction.image = UIImage(systemName: "arrow.up")
        
        return UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favoriteAction = UIContextualAction(style: .normal, title: nil) { (action, view, completionHandler) in
            let cell = tableView.cellForRow(at: indexPath) as! CustomCell
            if self.restaurants[indexPath.row].isFavorite {
                cell.accessoryType = .none
                self.restaurants[indexPath.row].isFavorite = false
                action.image = UIImage(systemName: "heart")
            } else {
                cell.accessoryType = .checkmark
                self.restaurants[indexPath.row].isFavorite = true
                action.image = UIImage(systemName: "heart.slash")
            }
            completionHandler(true)
        }
        
        favoriteAction.backgroundColor = .systemYellow
        favoriteAction.image = restaurants[indexPath.row].isFavorite ? UIImage(systemName: "heart.slash") : UIImage(systemName: "heart")
        
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
}

#Preview {
    RestaurantViewController()
}
