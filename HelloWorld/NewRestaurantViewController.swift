//
//  NewRestaurantViewController.swift
//  HelloWorld
//
//  Created by Sravan on 05/04/26.
//

import UIKit
import SnapKit
import PhotosUI

class NewRestaurantViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    private var selectedImage: UIImage?
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "New Restaurant"
        
        let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped))
        let rightBarButtonItem = UIBarButtonItem(title: "Save", style: .prominent, target: self, action: #selector(saveTapped))
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        // Customize the navigation bar appearance
        if let appearance = navigationController?.navigationBar.standardAppearance {
            if let customFont = UIFont(name: "Nunito-Bold", size: 18.0) {
                appearance.titleTextAttributes = [.font: customFont]
            }
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        
        setupViews()
        setupConstraints()
        
        // https://fluffy.es/move-view-when-keyboard-is-shown/#:~:text=One%20of%20the%20solution%20for,we%20move%20the%20view%20up.
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func saveTapped() {
        view.endEditing(true)

        let name = (view.viewWithTag(1) as? UITextField)?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let type = (view.viewWithTag(2) as? UITextField)?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let address = (view.viewWithTag(3) as? UITextField)?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let phone = (view.viewWithTag(4) as? UITextField)?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let desc = (view.viewWithTag(5) as? UITextView)?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        var errors: [(field: String, tag: Int)] = []
        if name.isEmpty { errors.append(("Name", 1)) }
        if type.isEmpty { errors.append(("Type", 2)) }
        if address.isEmpty { errors.append(("Address", 3)) }
        if phone.isEmpty || !isValidPhone(phone) { errors.append(("Phone", 4)) }
        if desc.isEmpty { errors.append(("Description", 5)) }

        if let firstError = errors.first {
            // Scroll to the first invalid field
            if let invalidView = view.viewWithTag(firstError.tag) {
                let rect = invalidView.convert(invalidView.bounds, to: tableView)
                tableView.scrollRectToVisible(rect, animated: true)
                invalidView.becomeFirstResponder()
            }

            let message = errors.map { "\($0.field) is invalid or empty." }.joined(separator: "\n")
            let alert = UIAlertController(title: "Please correct the following", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }

//        // All good — proceed to save (placeholder)
//        let alert = UIAlertController(title: "Success", message: "All fields validated. Implement saving here.", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default))
//        present(alert, animated: true)
        
        print("Name: \(name)")
        print("Type: \(type)")
        print("Location: \(address)")
        print("Phone: \(phone)")
        print("Description: \(desc)")
    }
    
    private func isValidPhone(_ phone: String) -> Bool {
        let digits = phone.filter { $0.isNumber }
        return (7...15).contains(digits.count)
    }
    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
    
    private func setupViews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(ImageViewTableCell.self, forCellReuseIdentifier: ImageViewTableCell.identifier)
        tableView.register(NameViewTableCell.self, forCellReuseIdentifier: NameViewTableCell.identifier)
        tableView.register(TypeViewTableCell.self, forCellReuseIdentifier: TypeViewTableCell.identifier)
        tableView.register(AddressViewTableCell.self, forCellReuseIdentifier: AddressViewTableCell.identifier)
        tableView.register(PhoneViewTableCell.self, forCellReuseIdentifier: PhoneViewTableCell.identifier)
        tableView.register(DescriptionViewTableCell.self, forCellReuseIdentifier: DescriptionViewTableCell.identifier)
        
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
//    @objc private func keyboardWillShow(_ notification: Notification) {
//        guard let userInfo = notification.userInfo,
//              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
//              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
//              let curveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
//
//        let keyboardHeight = view.convert(keyboardFrame, from: nil).height - view.safeAreaInsets.bottom
//        let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
//
//        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curveRaw << 16), animations: {
//            self.tableView.contentInset = insets
//            self.tableView.scrollIndicatorInsets = insets
//        })
//
//        // Ensure the active responder is visible
//        if let firstResponder = view.findFirstResponder(), let responderView = firstResponder as? UIView {
//            let rect = responderView.convert(responderView.bounds, to: tableView)
//            tableView.scrollRectToVisible(rect, animated: true)
//        }
//    }
//
//    @objc private func keyboardWillHide(_ notification: Notification) {
//        guard let userInfo = notification.userInfo,
//              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
//              let curveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
//
//        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curveRaw << 16), animations: {
//            self.tableView.contentInset = .zero
//            self.tableView.scrollIndicatorInsets = .zero
//        })
//    }
}

extension NewRestaurantViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageViewTableCell.identifier, for: indexPath) as! ImageViewTableCell
            cell.selectionStyle = .none
            cell.configure(image: selectedImage)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: NameViewTableCell.identifier, for: indexPath) as! NameViewTableCell
            cell.selectionStyle = .none
            cell.configureDelegate(self)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: TypeViewTableCell.identifier, for: indexPath) as! TypeViewTableCell
            cell.selectionStyle = .none
            cell.configureDelegate(self)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddressViewTableCell.identifier, for: indexPath) as! AddressViewTableCell
            cell.selectionStyle = .none
            cell.configureDelegate(self)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhoneViewTableCell.identifier, for: indexPath) as! PhoneViewTableCell
            cell.selectionStyle = .none
            cell.configureDelegate(self)
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionViewTableCell.identifier, for: indexPath) as! DescriptionViewTableCell
            cell.selectionStyle = .none
            return cell
        default:
            fatalError("Nothing to Handle")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    imagePicker.delegate = self
                    
                    self.present(imagePicker, animated: true)
                }
            }
            
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { action in
                var configuration = PHPickerConfiguration()
                configuration.filter = .images
                configuration.selectionLimit = 1
                
                let picker = PHPickerViewController(configuration: configuration)
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)
            photoSourceRequestController.addAction(cancelAction)
            
//            if let popOverViewController = photoSourceRequestController.popoverPresentationController {
//                if let cell = tableView.cellForRow(at: indexPath) {
//                    popOverViewController.sourceView = cell
//                    popOverViewController.sourceRect = cell.bounds
//                }
//            }
            
            present(photoSourceRequestController, animated: true)
        }
    }
}

extension NewRestaurantViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.selectedImage = image
            picker.dismiss(animated: true) {
                let indexPath = IndexPath(row: 0, section: 0)
                if self.tableView.indexPathsForVisibleRows?.contains(indexPath) == true,
                   let cell = self.tableView.cellForRow(at: indexPath) as? ImageViewTableCell {
                    cell.configure(image: image)
                } else {
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }
        } else {
            picker.dismiss(animated: true)
        }
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true) {
            guard let result = results.first else { return }
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    let indexPath = IndexPath(row: 0, section: 0)
                    DispatchQueue.main.async {
                        if let image = image as? UIImage, self?.tableView.indexPathsForVisibleRows?.contains(indexPath) == true,
                           let cell = self?.tableView.cellForRow(at: indexPath) as? ImageViewTableCell {
                            cell.configure(image: image)
                        } else if let error = error {
                            print("Error loading image: \(error)")
                        }
                    }
                }
            }
        }
    }
    
}

extension NewRestaurantViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextResponder = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

#Preview {
    NewRestaurantViewController()
}


class ImageViewTableCell: UITableViewCell {
    static let identifier = "ImageViewTableCell"
    
    private let newImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "newphoto")
        imageView.backgroundColor = .systemGray6
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
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
        contentView.addSubview(newImageView)
    }
    
    private func setupConstraints() {
        newImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.layoutMarginsGuide)
            make.height.equalTo(200)
        }
    }
    
    func configure(image: UIImage?) {
        if let image = image {
            newImageView.image = image
        } else {
            newImageView.image = UIImage(named: "newphoto")
        }
    }
}

class NameViewTableCell: UITableViewCell {
    static let identifier = "NameViewTableCell"
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "NAME"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .darkGray
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = RoundedTextField()
        textField.placeholder = "Fill in the restaurant name"
        textField.font = .preferredFont(forTextStyle: .body)
        textField.tag = 1
        textField.becomeFirstResponder()
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    func configureDelegate(_ delegate: UITextFieldDelegate) {
        nameTextField.delegate = delegate
        nameTextField.returnKeyType = .next
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(nameTextField)
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.layoutMarginsGuide)
        }
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
}

class TypeViewTableCell: UITableViewCell {
    static let identifier = "TypeViewTableCell"
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "TYPE"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .darkGray
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = RoundedTextField()
        textField.placeholder = "Fill in the restaurant type"
        textField.font = .preferredFont(forTextStyle: .body)
        textField.tag = 2
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    func configureDelegate(_ delegate: UITextFieldDelegate) {
        nameTextField.delegate = delegate
        nameTextField.returnKeyType = .next
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(nameTextField)
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.layoutMarginsGuide)
        }
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
}

class AddressViewTableCell: UITableViewCell {
    static let identifier = "AddressViewTableCell"
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "ADDRESS"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .darkGray
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = RoundedTextField()
        textField.placeholder = "Fill in the restaurant address"
        textField.font = .preferredFont(forTextStyle: .body)
        textField.tag = 3
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    func configureDelegate(_ delegate: UITextFieldDelegate) {
        nameTextField.delegate = delegate
        nameTextField.returnKeyType = .next
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(nameTextField)
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.layoutMarginsGuide)
        }
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
}

class PhoneViewTableCell: UITableViewCell {
    static let identifier = "PhoneViewTableCell"
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "PHONE"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .darkGray
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = RoundedTextField()
        textField.placeholder = "Fill in the restaurant phone"
        textField.font = .preferredFont(forTextStyle: .body)
        textField.tag = 4
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    func configureDelegate(_ delegate: UITextFieldDelegate) {
        nameTextField.delegate = delegate
        nameTextField.returnKeyType = .next
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(nameTextField)
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.layoutMarginsGuide)
        }
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
}

class DescriptionViewTableCell: UITableViewCell {
    static let identifier = "DescriptionViewTableCell"
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "DESCRIPTION"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .darkGray
        return label
    }()
    
    private let nameTextField: UITextView = {
        let textView = UITextView()
        textView.text = "A great restaurant to try out"
        textView.font = .preferredFont(forTextStyle: .body)
        textView.backgroundColor = .systemGray6
        textView.layer.cornerRadius = 10
        textView.clipsToBounds = true
        textView.tag = 5
        return textView
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
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(nameTextField)
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.layoutMarginsGuide)
        }
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
    }
}

class RoundedTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.systemGray5.cgColor
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
    }
}

//private extension UIView {
//    func findFirstResponder() -> UIView? {
//        if isFirstResponder { return self }
//        for subview in subviews {
//            if let responder = subview.findFirstResponder() { return responder }
//        }
//        return nil
//    }
//}

