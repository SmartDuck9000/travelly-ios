//
//  EditProfileViewController.swift
//  Travelly
//
//  Created by Георгий Куликов on 03.04.2021.
//

import UIKit

fileprivate struct LayoutConstants {
    static let containerViewTopSpace: CGFloat = 15
    static let containerViewLeftSpace: CGFloat = 15
    static let containerViewRightSpace: CGFloat = -15
    static let containerViewHeight: CGFloat = 150
    static let betweenFieldsSpace: CGFloat = 15
    
    static let nameStackTopSpace: CGFloat = 25
    
    static let photoLeftSpace: CGFloat = 0
    static let photoTopSpace: CGFloat = 15
    static let photoBottomSpace: CGFloat = -15
    
    static let saveButtonLeftSpace: CGFloat = 15
    static let saveButtonRightSpace: CGFloat = -15
    static let saveButtonHeight: CGFloat = 40
    static let saveButtonTitle = "Сохранить"
    
    static let firstNamePlaceholder = "Имя"
    static let lastNamePlaceholder = "Фамилия"
    
    static let nameStackLeftSpace: CGFloat = 15
    static let nameStackRightSpace: CGFloat = -15
    
    static let emailPlaceholder = "Новая почта"
    static let oldPasswordPlaceholder = "Пароль"
    static let newPasswordPlaceholder = "Новый пароль"
}

class EditProfileViewController: UIViewController {
    
    private var presenter: EditProfilePresenterProtocol?
    
    private let containerView = UIView()
    private let photoImageView = UIImageView()
    private var imageChanged = false
    private let nameFieldStackView = UIStackView()
    private let firstNameField = UITextField()
    private let lastNameField = UITextField()
    
    private let fieldStackView = UIStackView()
    private let emailField = UITextField()
    private let oldPasswordField = UITextField()
    private let newPasswordField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc
    private func saveChanges() {
        presenter?.saveChanges()
    }
    
    @objc
    private func changePhotoPressed(sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc
    private func goBack() {
        presenter?.goBack()
    }
    
    func showError(message: String) {
        
    }
    
    func set(presenter: EditProfilePresenterProtocol) {
        self.presenter = presenter
    }
    
    func setFirstName(_ firstName: String) {
        DispatchQueue.main.async {
            self.firstNameField.text = firstName
        }
    }
    
    func setLastName(_ lastName: String) {
        DispatchQueue.main.async {
            self.lastNameField.text = lastName
        }
    }
    
    func getFirstName() -> String? {
        return firstNameField.text
    }
    
    func getLastName() -> String? {
        return lastNameField.text
    }
    
    func getEmail() -> String? {
        return emailField.text
    }
    
    func getOldPassword() -> String? {
        return oldPasswordField.text
    }
    
    func getNewPassword() -> String? {
        return newPasswordField.text
    }
    
    func getPhotoImageView() -> UIImageView {
        return photoImageView
    }
    
    func isImageChanged() -> Bool {
        return imageChanged
    }
    
    func getPhotoImageViewSize() -> CGFloat {
        return LayoutConstants.containerViewHeight - LayoutConstants.photoTopSpace * 2
    }
    
    private func setupView() {
        self.view.backgroundColor = AppColorAppearance.backgroundColor
        
        setupNavigationBar()
        setupContainerView()
        setupFieldStackView()
        
        presenter?.setupProfileData()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = NavigationBarAppearance.backgroundColor
        self.navigationController?.navigationBar.isTranslucent = false
        
        let backArrowImage = UIImage(named: "BackArrow")
        let backButton = UIButton()
        backButton.setTitle("Профиль", for: .normal)
        backButton.setImage(backArrowImage, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        let saveButton = UIButton()
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
    }
    
    private func setupContainerView() {
        self.view.addSubview(containerView)
        let safeArea = self.view.safeAreaLayoutGuide
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: LayoutConstants.containerViewTopSpace).isActive = true
        containerView.leftAnchor.constraint(equalTo: safeArea.leftAnchor,
                                            constant: LayoutConstants.containerViewLeftSpace).isActive = true
        containerView.rightAnchor.constraint(equalTo: safeArea.rightAnchor,
                                             constant: LayoutConstants.containerViewRightSpace).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: LayoutConstants.containerViewHeight).isActive = true
        
        setupPhotoImageView()
        setupNameFieldStackView()
    }
    
    private func setupPhotoImageView() {
        self.containerView.addSubview(photoImageView)
        
        photoImageView.isUserInteractionEnabled = true
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changePhotoPressed(sender:)))
        singleTap.numberOfTapsRequired = 1
        photoImageView.addGestureRecognizer(singleTap)
        
        photoImageView.layer.cornerRadius = (LayoutConstants.containerViewHeight - LayoutConstants.photoTopSpace * 2) / 2
        photoImageView.clipsToBounds = true
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: LayoutConstants.photoTopSpace).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,
                                               constant: LayoutConstants.photoBottomSpace).isActive = true
        photoImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: LayoutConstants.photoLeftSpace).isActive = true
        photoImageView.widthAnchor.constraint(
            equalToConstant: LayoutConstants.containerViewHeight - LayoutConstants.photoTopSpace * 2
        ).isActive = true
    }
    
    private func setupNameFieldStackView() {
        nameFieldStackView.axis = NSLayoutConstraint.Axis.vertical
        nameFieldStackView.distribution = .equalSpacing
        nameFieldStackView.alignment = .center
        nameFieldStackView.spacing = LayoutConstants.betweenFieldsSpace
        
        self.containerView.addSubview(nameFieldStackView)
        
        nameFieldStackView.translatesAutoresizingMaskIntoConstraints = false
        nameFieldStackView.topAnchor.constraint(equalTo: containerView.topAnchor,
                                                constant: LayoutConstants.nameStackTopSpace).isActive = true
        nameFieldStackView.leftAnchor.constraint(equalTo: photoImageView.rightAnchor,
                                                 constant: LayoutConstants.nameStackLeftSpace).isActive = true
        nameFieldStackView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        setupFirstNameField()
        setupLastNameField()
    }
    
    private func setupFirstNameField() {
        setup(stackView: nameFieldStackView, field: firstNameField, placeholder: LayoutConstants.firstNamePlaceholder)
    }

    private func setupLastNameField() {
        setup(stackView: nameFieldStackView, field: lastNameField, placeholder: LayoutConstants.lastNamePlaceholder)
    }
    
    
    private func setupFieldStackView() {
        fieldStackView.axis = NSLayoutConstraint.Axis.vertical
        fieldStackView.distribution = .equalSpacing
        fieldStackView.alignment = .center
        fieldStackView.spacing = LayoutConstants.betweenFieldsSpace
        
        self.view.addSubview(fieldStackView)
        let safeArea = self.view.safeAreaLayoutGuide
        
        fieldStackView.translatesAutoresizingMaskIntoConstraints = false
        fieldStackView.topAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        fieldStackView.leftAnchor.constraint(equalTo: safeArea.leftAnchor,
                                             constant: LayoutConstants.nameStackLeftSpace).isActive = true
        fieldStackView.rightAnchor.constraint(equalTo: safeArea.rightAnchor,
                                              constant: LayoutConstants.nameStackRightSpace).isActive = true
        
        setupEmailField()
        setupOldPasswordField()
        setupNewPasswordField()
    }
    
    private func setupEmailField() {
        setup(stackView: fieldStackView, field: emailField, placeholder: LayoutConstants.emailPlaceholder)
    }
    
    private func setupOldPasswordField() {
        setup(stackView: fieldStackView, field: oldPasswordField, placeholder: LayoutConstants.oldPasswordPlaceholder)
    }
    
    private func setupNewPasswordField() {
        setup(stackView: fieldStackView, field: newPasswordField, placeholder: LayoutConstants.newPasswordPlaceholder)
    }
    
    private func setup(stackView: UIStackView, field: UITextField, placeholder: String?) {
        stackView.addArrangedSubview(field)
        
        field.setLeftPaddingPoints(AuthTextFieldAppearance.leftPadding)
        field.setRightPaddingPoints(AuthTextFieldAppearance.rightPadding)
        field.backgroundColor = AuthTextFieldAppearance.bgColor
        field.layer.cornerRadius = view.safeAreaLayoutGuide.layoutFrame.size.width * AuthTextFieldAppearance.cornerRadiusRatio
        
        field.font = AuthTextFieldAppearance.font
        let placeholderAttributes = [NSAttributedString.Key.foregroundColor : AuthTextFieldAppearance.placeholderColor]
        field.attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: placeholderAttributes)
        field.textColor = AuthTextFieldAppearance.textColor
        
        field.translatesAutoresizingMaskIntoConstraints = false
        field.heightAnchor.constraint(equalToConstant: AuthTextFieldAppearance.height).isActive = true
        field.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        field.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
    }
}


extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let newImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            photoImageView.image = newImage
            imageChanged = true
        } else if let newImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = newImage
            imageChanged = true
        }
        
        dismiss(animated: true, completion: nil)
    }
}
