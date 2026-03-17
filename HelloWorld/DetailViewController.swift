//
//  DetailViewController.swift
//  HelloWorld
//
//  Created by Sravan Goud on 17/03/26.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configure(restaurant: Restaurant) {
        titleLabel.text = restaurant.name
    }
}
