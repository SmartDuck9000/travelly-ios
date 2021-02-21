//
//  RegisterViewController.swift
//  Travelly
//
//  Created by Георгий Куликов on 14.02.2021.
//

import UIKit

fileprivate struct LayoutConstants {
    static let leftSpace: CGFloat = 15
    static let rightSpace: CGFloat = -15
    static let bottomSpace: CGFloat = -20
    static let topSpace: CGFloat = 20
    static let betweenIconStackSpace: CGFloat = -40
    static let betweenFieldsSpace: CGFloat = 10
    
    static let buttonHeight: CGFloat = 42
}

class RegisterViewController: UIViewController {
    private var presenter: RegisterPresenterProtocol?
    
    private let goBackButton = UIButton()
    private let containerIconView = UIView()
    private let iconImageView = UIImageView()
    
    private let stackView = UIStackView()
    private let emailField = UITextField()
    private let firstNameField = UITextField()
    private let lastNameField = UITextField()
    
    private let registerButton = UIButton()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
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
        setupIconImageView()
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
        goBackButton.setImage(UIImage(named: "arrow.left"), for: .normal)
        goBackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        goBackButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
    }
    
    private func setupIconImageView() {
        self.view.addSubview(containerIconView)
        containerIconView.addSubview(iconImageView)
        iconImageView.image = UIImage(named: "AuthImage.png")
        
        containerIconView.translatesAutoresizingMaskIntoConstraints = false
        containerIconView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerIconView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerIconView.bottomAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.centerYAnchor.constraint(equalTo: containerIconView.centerYAnchor).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: containerIconView.centerXAnchor).isActive = true
    }
    
    private func setupStackView() {
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(firstNameField)
        stackView.addArrangedSubview(lastNameField)
        
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = LayoutConstants.betweenFieldsSpace
        
        self.view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        stackView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: LayoutConstants.leftSpace).isActive = true
        
        stackView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: LayoutConstants.rightSpace).isActive = true
    }
    
    private func setupEmailField() {
        setup(field: emailField, placeholder: "Почта")
    }
    
    private func setupFirstNameField() {
        setup(field: firstNameField, placeholder: "Имя")
    }
    
    private func setupLastNameField() {
        setup(field: lastNameField, placeholder: "Фамилия")
    }
    
    private func setup(field: UITextField, placeholder: String?) {
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
    
    private func setupRegisterButton() {
        self.view.addSubview(registerButton)
        
        registerButton.setTitle("Зарегистрироваться", for: .normal)
        registerButton.setTitleColor(MainButtonAppearance.textColor, for: .normal)
        registerButton.titleLabel?.font = MainButtonAppearance.font
        
        registerButton.backgroundColor = MainButtonAppearance.backgroundColor
        registerButton.layer.cornerRadius = view.safeAreaLayoutGuide.layoutFrame.size.width * MainButtonAppearance.cornerRadiusRatio
        
        registerButton.isEnabled = false
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: LayoutConstants.leftSpace).isActive = true
        
        registerButton.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: LayoutConstants.rightSpace).isActive = true
        
        registerButton.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: LayoutConstants.bottomSpace).isActive = true
        
        registerButton.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonHeight).isActive = true
    }

}
