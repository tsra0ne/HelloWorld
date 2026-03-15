//
//  SimpleTableViewController.swift
//  HelloWorld
//
//  Created by Sravan on 15/03/26.
//

import UIKit
import SnapKit

class DataCell: UITableViewCell {
    
    static let identifier = "DataCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
    }
    
    private func setupConstraints() {
        
    }
}

// Modern

nonisolated enum Section { case main }

class SimpleTableDiffableViewController: UIViewController {
    
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
            let cell = tableView.dequeueReusableCell(withIdentifier: DataCell.identifier, for: indexPath) as! DataCell
            var content = cell.defaultContentConfiguration()
            content.text = self.restaurantNames[indexPath.row]
            content.image = UIImage(named: "restaurant")
            cell.contentConfiguration = content
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
        tableView.rowHeight = 60
        tableView.estimatedRowHeight = 60
        tableView.register(DataCell.self, forCellReuseIdentifier: DataCell.identifier)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


// Legacy

class SimpleTableViewController: UIViewController {
    
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
    }
    
    private func setupViews() {
        tableView.rowHeight = 60
        tableView.estimatedRowHeight = 60
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DataCell.self, forCellReuseIdentifier: DataCell.identifier)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SimpleTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        restaurantNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DataCell.identifier, for: indexPath) as! DataCell
        var content = cell.defaultContentConfiguration()
        content.text = restaurantNames[indexPath.row]
        content.image = UIImage(named: "restaurant")
//        content.directionalLayoutMargins = .zero
        cell.contentConfiguration = content
        return cell
    }
}

