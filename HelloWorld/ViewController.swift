//
//  ViewController.swift
//  HelloWorld
//
//  Created by Sravan on 07/03/26.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var helloButton1: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Hello World", for: .normal)
        button.addTarget(nil, action: #selector(showMessage), for: .touchUpInside)
        var config = UIButton.Configuration.filled()
        // Apply large font through configuration so it isn't overridden
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var attrs = incoming
            attrs.font = UIFont.systemFont(ofSize: 70)
            return attrs
        }
        button.configuration = config
        button.backgroundColor = .systemPurple
        return button
    }()
    
    private var helloButton2: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Hello World", for: .normal)
        button.addTarget(nil, action: #selector(showMessage), for: .touchUpInside)
        var config = UIButton.Configuration.filled()
        // Apply large font through configuration so it isn't overridden
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var attrs = incoming
            attrs.font = UIFont.systemFont(ofSize: 70)
            return attrs
        }
        button.configuration = config
        button.backgroundColor = .systemPurple
        return button
    }()
    
    private var helloButton3: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Hello World", for: .normal)
        button.addTarget(nil, action: #selector(showMessage), for: .touchUpInside)
        var config = UIButton.Configuration.filled()
        // Apply large font through configuration so it isn't overridden
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var attrs = incoming
            attrs.font = .systemFont(ofSize: 70)
            return attrs
        }
        button.configuration = config
        button.backgroundColor = .systemPurple
        return button
    }()
    
    private var helloButton4: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSAttributedString(
            string: "Hello World",
            attributes: [.font: UIFont.systemFont(ofSize: 70)]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(nil, action: #selector(showMessage), for: .touchUpInside)
        button.configuration = .filled()
        button.backgroundColor = .systemPurple
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(helloButton1)
        view.addSubview(helloButton2)
        view.addSubview(helloButton3)
        view.addSubview(helloButton4)
    }
    
    private func setupConstraints() {
        helloButton1.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.layoutMarginsGuide)
        }
        helloButton2.snp.makeConstraints { make in
            make.top.equalTo(helloButton1.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.layoutMarginsGuide)
        }
        helloButton3.snp.makeConstraints { make in
            make.top.equalTo(helloButton2.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.layoutMarginsGuide)
        }
        helloButton4.snp.makeConstraints { make in
            make.top.equalTo(helloButton3.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.layoutMarginsGuide)
        }
    }
    
    @objc func showMessage(sender: UIButton) {
        let selectedButton = sender
        // Get the emoji from the title label of the selected button
        if let wordToLookup = selectedButton.titleLabel?.text {
            print("\(wordToLookup)")
        }
        let alertController = UIAlertController(title: "Welcome to my First App", message: "Hello World", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}

