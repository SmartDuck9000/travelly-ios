//
//  EditProfileViewController.swift
//  Travelly
//
//  Created by Георгий Куликов on 03.04.2021.
//

import UIKit

fileprivate struct LayoutConstants {
    static let photoLeftSpace: CGFloat = 10
    
    static let saveButtonLeftSpace: CGFloat = 15
    static let saveButtonRightSpace: CGFloat = -15
    static let saveButtonHeight: CGFloat = 40
    
    static let firstNamePlaceholder = "Имя"
    static let lastNamePlaceholder = "Фамилия"
    
    static let emailPlaceholder = "Почта"
    static let oldPasswordPlaceholder = "Старый пароль"
    static let newPasswordPlaceholder = "Новый пароль"
}

class EditProfileViewController: UIViewController {
    
    private var presenter: EditProfilePresenterProtocol?
    
    private let containerView = UIView()
    private let photoImageView = UIImageView()
    private let nameFieldStackView = UIStackView()
    private let firstNameField = UITextField()
    private let lastNameField = UITextField()
    
    private let fieldStackView = UIStackView()
    private let emailField = UITextField()
    private let oldPasswordField = UITextField()
    private let newPasswordField = UITextField()
    
    private let saveButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc
    private func saveChanges() {
        presenter?.saveChanges()
    }
    
    func set(presenter: EditProfilePresenterProtocol) {
        self.presenter = presenter
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
    
    private func setupView() {
        setupContainerView()
        setupSaveButton()
        setupFieldStackView()
    }
    
    private func setupContainerView() {
        self.view.addSubview(containerView)
        let safeArea = self.view.safeAreaLayoutGuide
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        
        setupPhotoImageView()
        setupNameFieldStackView()
    }
    
    private func setupPhotoImageView() {
        self.containerView.addSubview(photoImageView)
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        photoImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: LayoutConstants.photoLeftSpace).isActive = true
    }
    
    private func setupNameFieldStackView() {
        self.containerView.addSubview(nameFieldStackView)
        
        nameFieldStackView.translatesAutoresizingMaskIntoConstraints = false
        nameFieldStackView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        nameFieldStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        nameFieldStackView.leftAnchor.constraint(equalTo: photoImageView.rightAnchor).isActive = true
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
        self.view.addSubview(fieldStackView)
        let safeArea = self.view.safeAreaLayoutGuide
        
        fieldStackView.translatesAutoresizingMaskIntoConstraints = false
        fieldStackView.topAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        fieldStackView.bottomAnchor.constraint(equalTo: saveButton.topAnchor).isActive = true
        fieldStackView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        fieldStackView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        
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
    
    private func setupSaveButton() {
        self.view.addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        let safeArea = self.view.safeAreaLayoutGuide
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: LayoutConstants.saveButtonLeftSpace).isActive = true
        saveButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: LayoutConstants.saveButtonRightSpace).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: LayoutConstants.saveButtonHeight).isActive = true
    }
}
