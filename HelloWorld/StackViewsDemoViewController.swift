//
//  StackViewsDemoViewController.swift
//  HelloWorld
//
//  Created by Sravan on 14/03/26.
//

import UIKit
import SnapKit

class StackViewsDemoViewController: UIViewController {
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 27
        return stack
    }()
    
    private let labelStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()
    
    private let imageStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Instant Developer"
//        label.font = if UIDevice.current.userInterfaceIdiom == .pad {
//            .systemFont(ofSize: 65, weight: .medium)
//        } else {
//            .systemFont(ofSize: 40, weight: .medium)
//        }
        label.font = .systemFont(ofSize: 40, weight: .medium)
        label.textColor = .systemIndigo
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Get help from experts in 15 minutes"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
    }()
    
    private let registerLabel: UILabel = {
        let label = UILabel()
        label.text = "Need help with coding problems? Register!"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let image1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "user1")
        return imageView
    }()
    
    private let image2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "user2")
        return imageView
    }()
    
    private let image3: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "user3")
        return imageView
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemIndigo
        config.cornerStyle = .fixed
        button.configuration = config
        let attributedTitle = NSAttributedString(
            string: "Sign Up",
            attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemGray
        config.cornerStyle = .fixed
        button.configuration = config
        let attributedTitle = NSAttributedString(
            string: "Log In",
            attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        
        registerForTraitChanges([UITraitVerticalSizeClass.self, UITraitHorizontalSizeClass.self]) { (self: Self, previousTraitCollection) in
            self.updateUIForSizeClass()
        }
    }
    
    private func setupViews() {
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(subtitleLabel)
        imageStackView.addArrangedSubview(image1)
        imageStackView.addArrangedSubview(image2)
        imageStackView.addArrangedSubview(image3)
        containerStackView.addArrangedSubview(labelStackView)
        containerStackView.addArrangedSubview(imageStackView)
        containerStackView.addArrangedSubview(registerLabel)
        buttonStackView.addArrangedSubview(signupButton)
        buttonStackView.addArrangedSubview(loginButton)
        view.addSubview(containerStackView)
        view.addSubview(buttonStackView)
    }
    
    private func setupConstraints() {
        updateUIForSizeClass()
        [image1, image2, image3].forEach { imageView in
            imageView.snp.makeConstraints { make in
                make.height.equalTo(imageView.snp.width).multipliedBy(134.0 / 100.0)
            }
        }
        signupButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 250, height: 50))
        }
        loginButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 250, height: 50))
        }
    }
    
    private func updateUIForSizeClass() {
        let isPortrait = traitCollection.verticalSizeClass == .regular
        let isIPad = traitCollection.verticalSizeClass == .regular && traitCollection.horizontalSizeClass == .regular
        
        titleLabel.font = .systemFont(ofSize: isIPad ? 65 : 40, weight: .medium)
        if isPortrait {
            containerStackView.snp.remakeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
                make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            }
            containerStackView.alignment = .fill
            buttonStackView.axis = .vertical
            buttonStackView.snp.remakeConstraints { make in
                make.centerX.equalTo(view.safeAreaLayoutGuide)
                make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            }
        } else {
            containerStackView.snp.remakeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide)
                make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            }
            containerStackView.alignment = .center
            buttonStackView.axis = .horizontal
            buttonStackView.snp.remakeConstraints { make in
                make.centerX.bottom.equalTo(view.safeAreaLayoutGuide).inset(0)
            }
        }
    }

}

#Preview {
    StackViewsDemoViewController()
}

