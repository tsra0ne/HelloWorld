//
//  RestaurantReviewViewController.swift
//  HelloWorld
//
//  Created by Sravan on 05/04/26.
//

import UIKit
import SnapKit

protocol RestaurantReviewDelegate: AnyObject {
    func didSelectRating(rating: Restaurant.Rating)
}

class RestaurantReviewViewController: UIViewController {
    
    weak var delegate: RestaurantReviewDelegate?
    
    private let restaurantImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        let pointSize: CGFloat = 20.0 // Adjust the size as needed
        let imageConfig = UIImage.SymbolConfiguration(pointSize: pointSize)
        let image = UIImage(systemName: "xmark", withConfiguration: imageConfig)
        config.image = image
        config.baseForegroundColor = .white
        button.configuration = config
        button.addTarget(nil, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    private let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 10
        return stack
    }()
    
    private let loveButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "love")
        config.baseForegroundColor = .white
        button.configuration = config
        let attributedTitle = NSAttributedString(
            string: Restaurant.Rating.awesome.image,
            attributes: [.font: UIFont.preferredFont(forTextStyle: .largeTitle)]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(nil, action: #selector(selectedRating), for: .touchUpInside)
        return button
    }()
    
    private let coolButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "cool")
        config.baseForegroundColor = .white
        button.configuration = config
        let attributedTitle = NSAttributedString(
            string: Restaurant.Rating.good.image,
            attributes: [.font: UIFont.preferredFont(forTextStyle: .largeTitle)]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(nil, action: #selector(selectedRating), for: .touchUpInside)
        return button
    }()
    
    private let happyButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "happy")
        config.baseForegroundColor = .white
        button.configuration = config
        let attributedTitle = NSAttributedString(
            string: Restaurant.Rating.okay.image,
            attributes: [.font: UIFont.preferredFont(forTextStyle: .largeTitle)]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(nil, action: #selector(selectedRating), for: .touchUpInside)
        return button
    }()
    
    private let sadButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "sad")
        config.baseForegroundColor = .white
        button.configuration = config
        let attributedTitle = NSAttributedString(
            string: Restaurant.Rating.bad.image,
            attributes: [.font: UIFont.preferredFont(forTextStyle: .largeTitle)]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(nil, action: #selector(selectedRating), for: .touchUpInside)
        return button
    }()
    
    private let angryButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "angry")
        config.baseForegroundColor = .white
        button.configuration = config
        let attributedTitle = NSAttributedString(
            string: Restaurant.Rating.terrible.image,
            attributes: [.font: UIFont.preferredFont(forTextStyle: .largeTitle)]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(nil, action: #selector(selectedRating), for: .touchUpInside)
        return button
    }()
    
    private let rateButtons: [UIButton]
    
    private let restaurant: Restaurant
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        self.rateButtons = [loveButton, coolButton, happyButton, sadButton, angryButton]
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let moveTopTransform = CGAffineTransform.init(translationX: 0, y: -200)
        
        closeButton.transform = moveTopTransform
        
        let moveRightTransform = CGAffineTransform.init(translationX: 600, y: 0)
        let scaleUpTransform = CGAffineTransform.init(scaleX: 5.0, y: 5.0)
        let moveScaleTransform = scaleUpTransform.concatenating(moveRightTransform)
        
        // Make the button invisible
        for rateButton in rateButtons {
            rateButton.transform = moveScaleTransform
            rateButton.alpha = 0
        }
        
        setupViews()
        setupConstraints()
        
        restaurantImage.image = UIImage(named: restaurant.image)
        
        // Applying the blur effect
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        restaurantImage.addSubview(blurEffectView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.4, delay: 0.1) {
            self.closeButton.transform = .identity
        }
        
        UIView.animate(withDuration: 0.4, delay: 0.1) {
            self.rateButtons[0].alpha = 1.0
            self.rateButtons[0].transform = .identity
        }
        
        UIView.animate(withDuration: 0.4, delay: 0.15) {
            self.rateButtons[1].alpha = 1.0
            self.rateButtons[1].transform = .identity
        }
        
        UIView.animate(withDuration: 0.4, delay: 0.2) {
            self.rateButtons[2].alpha = 1.0
            self.rateButtons[2].transform = .identity
        }
        
        UIView.animate(withDuration: 0.4, delay: 0.25) {
            self.rateButtons[3].alpha = 1.0
            self.rateButtons[3].transform = .identity
        }
        
        UIView.animate(withDuration: 0.4, delay: 0.3) {
            self.rateButtons[4].alpha = 1.0
            self.rateButtons[4].transform = .identity
        }
        
//        UIView.animate(withDuration: 2.0) {
//            self.rateButtons[0].alpha = 1.0
//            self.rateButtons[1].alpha = 1.0
//            self.rateButtons[2].alpha = 1.0
//            self.rateButtons[3].alpha = 1.0
//            self.rateButtons[4].alpha = 1.0
//        }
    }
    
    private func setupViews() {
        view.addSubview(restaurantImage)
        view.addSubview(closeButton)
        for rateButton in rateButtons {
            buttonStackView.addArrangedSubview(rateButton)
        }
        view.addSubview(buttonStackView)
    }
    
    private func setupConstraints() {
        restaurantImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        buttonStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc private func selectedRating(_ sender: UIButton) {
        let rating: Restaurant.Rating
        switch sender {
        case loveButton:
            rating = .awesome
        case coolButton:
            rating = .good
        case happyButton:
            rating = .okay
        case sadButton:
            rating = .bad
        case angryButton:
            rating = .terrible
        default:
            return
        }
        delegate?.didSelectRating(rating: rating)
        dismiss(animated: true)
    }
}
