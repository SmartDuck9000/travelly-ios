//
//  RegisterViewController.swift
//  Travelly
//
//  Created by Георгий Куликов on 14.02.2021.
//

import UIKit

class RegisterViewController: UIViewController {
    private var presenter: RegisterPresenterProtocol?
    
    private let goBackButton = UIButton()
    
    private let stackView = UIStackView()
    private let emailField = UITextField()
    private let firstNameField = UITextField()
    private let lastNameField = UITextField()
    
    private let registerButton = UIButton()
    
    public func setPresenter(_ presenter: RegisterPresenterProtocol) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = AppColorAppearance.appBackgroundColor
        
        setupGoBackButton()
        setupStackView()
        setupEmailField()
        setupFirstNameField()
        setupLastNameField()
        setupRegisterButton()
    }
    
    @objc
    private func goBackButtonPressed() {
        presenter?.goBack()
    }
    
    @objc
    private func registerButtonPressed() {
        presenter?.register()
    }
    
    private func setupGoBackButton() {
        self.view.addSubview(goBackButton)
        goBackButton.addTarget(self, action: #selector(goBackButtonPressed), for: .touchUpInside)
        
        goBackButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupStackView() {
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(firstNameField)
        stackView.addArrangedSubview(lastNameField)
        
        self.view.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupEmailField() {
        emailField.setLeftPaddingPoints(AuthTextFieldAppearance.leftPadding)
        emailField.setRightPaddingPoints(AuthTextFieldAppearance.rightPadding)
        emailField.layer.cornerRadius = view.safeAreaLayoutGuide.layoutFrame.size.width * AuthTextFieldAppearance.cornerRadiusRatio
        emailField.font = AuthTextFieldAppearance.font
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupFirstNameField() {
        firstNameField.setLeftPaddingPoints(AuthTextFieldAppearance.leftPadding)
        firstNameField.setRightPaddingPoints(AuthTextFieldAppearance.rightPadding)
        firstNameField.layer.cornerRadius = view.safeAreaLayoutGuide.layoutFrame.size.width * AuthTextFieldAppearance.cornerRadiusRatio
        firstNameField.font = AuthTextFieldAppearance.font
        
        firstNameField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLastNameField() {
        lastNameField.setLeftPaddingPoints(AuthTextFieldAppearance.leftPadding)
        lastNameField.setRightPaddingPoints(AuthTextFieldAppearance.rightPadding)
        lastNameField.layer.cornerRadius = view.safeAreaLayoutGuide.layoutFrame.size.width * AuthTextFieldAppearance.cornerRadiusRatio
        lastNameField.font = AuthTextFieldAppearance.font
        
        lastNameField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupRegisterButton() {
        registerButton.setTitle("Зарегистрироваться", for: .normal)
        registerButton.setTitleColor(MainButtonAppearance.textColor, for: .normal)
        registerButton.titleLabel?.font = UIFont(name: MainButtonAppearance.fontName, size: MainButtonAppearance.fontSize)
        
        registerButton.backgroundColor = MainButtonAppearance.backgroundColor
        registerButton.layer.cornerRadius = view.safeAreaLayoutGuide.layoutFrame.size.width * MainButtonAppearance.cornerRadiusRatio
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
    }

}
