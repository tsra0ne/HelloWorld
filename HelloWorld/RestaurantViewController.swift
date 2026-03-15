//
//  RestaurantViewController.swift
//  HelloWorld
//
//  Created by Sravan on 15/03/26.
//

import UIKit
import SnapKit

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
        imageView.image = UIImage(named: "restaurant")
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
            make.edges.equalToSuperview().inset(10)
        }
        restaurantImage.snp.makeConstraints { make in
            make.width.height.equalTo(120)
        }
    }
    
    func configure(name: String) {
        restaurantLabel.text = name
    }
}

class RestaurantViewController: UIViewController {
    
    private var restaurantNames = [
        "Bites & Brilliance",
        "Savory Sojourn",
        "The Gilded Plate",
        "Azure Evenings",
        "The Gourmet Hearth",
        "The Sizzling Sirloin",
        "Happy Spoon",
        "Nomad Nibbles",
        "Verdant Ventures",
        "Ready to Wok",
        "The Codfather",
        "Eggtastic Breakfasts",
        "Taco Bout It",
        "Burger Meister",
        "The Fresh and the Furious",
        "Bella Vita",
        "The Rusty Spoon",
        "Urban Kitchen",
        "Blue Moon",
        "Culinary Canopy",
        "Taste & Tell Bistro",
        "The Gastronomy Gallery",
        "Fork & Fortune Cafe",
        "Crave & Create Kitchen",
        "The Griddle Cafe",
        "Rise & Dine",
        "The Supper Club",
        "Sunny Side Up",
        "The Lazy Skillet",
        "Brunch & Bubbles"
      ]
    
    typealias DataSource = UITableViewDiffableDataSource<Section, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>
    
    var dataSource: DataSource!
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
            cell.configure(name: self.restaurantNames[indexPath.row])
            return cell
        }
    }
    
    private func applySnapshot(data: [String], animatingDifferences: Bool = true) {
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
        setupViews()
        setupConstraints()
        configureDataSource()
        applySnapshot(data: restaurantNames)
    }
    
    private func setupViews() {
        tableView.rowHeight = 140
        tableView.estimatedRowHeight = 140
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

#Preview {
    RestaurantViewController()
}
