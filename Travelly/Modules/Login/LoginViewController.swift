//
//  LoginViewController.swift
//  Travelly
//
//  Created by Георгий Куликов on 20.02.2021.
//

import UIKit

fileprivate struct LayoutConstants {
    static let goBackImageSize: CGFloat = 30
    
    static let leftSpace: CGFloat = 15
    static let rightSpace: CGFloat = -15
    static let bottomSpace: CGFloat = -20
    static let topSpace: CGFloat = 20
    static let betweenIconStackSpace: CGFloat = -40
    static let betweenFieldsSpace: CGFloat = 10
    
    static let buttonHeight: CGFloat = 42
}

class LoginViewController: UIViewController {

    private var presenter: LoginPresenterProtocol?
    
    private let goBackButton = UIButton()
    private let containerIconView = UIView()
    private let iconImageView = UIImageView()
    
    private let stackView = UIStackView()
    private let emailField = UITextField()
    private let passwordField = UITextField()
    
    private let loginButton = UIButton()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
    public func setPresenter(_ presenter: LoginPresenterProtocol) {
        self.presenter = presenter
    }
    
    public func getEmail() -> String? {
        return emailField.text
    }
    
    public func getPassword() -> String? {
        return passwordField.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = AppColorAppearance.backgroundColor
        
        setupGoBackButton()
        setupStackView()
        setupEmailField()
        setupPasswordField()
        setupIconImageView()
        setupLoginButton()
    }
    
    @objc
    private func goBackButtonPressed() {
        presenter?.goBack()
    }
    
    @objc
    private func loginButtonPressed() {
        presenter?.login()
    }
    
    private func setupGoBackButton() {
        self.view.addSubview(goBackButton)
        goBackButton.addTarget(self, action: #selector(goBackButtonPressed), for: .touchUpInside)
        
        let xmarkImage = UIImage(named: "TravellyXmark.png")
        
        goBackButton.translatesAutoresizingMaskIntoConstraints = false
        goBackButton.setImage(xmarkImage, for: .normal)
        goBackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutConstants.topSpace).isActive = true
        goBackButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
        goBackButton.heightAnchor.constraint(equalToConstant: LayoutConstants.goBackImageSize).isActive = true
        goBackButton.widthAnchor.constraint(equalToConstant: LayoutConstants.goBackImageSize).isActive = true
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
        stackView.addArrangedSubview(passwordField)
        
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
    
    private func setupPasswordField() {
        setup(field: passwordField, placeholder: "Пароль")
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
    
    private func setupLoginButton() {
        self.view.addSubview(loginButton)
        
        loginButton.setTitle("Войти", for: .normal)
        loginButton.setTitleColor(MainButtonAppearance.textColor, for: .normal)
        loginButton.titleLabel?.font = MainButtonAppearance.font
        
        loginButton.backgroundColor = MainButtonAppearance.backgroundColor
        loginButton.layer.cornerRadius = view.safeAreaLayoutGuide.layoutFrame.size.width * MainButtonAppearance.cornerRadiusRatio
        
        loginButton.isEnabled = true
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: LayoutConstants.leftSpace).isActive = true
        
        loginButton.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: LayoutConstants.rightSpace).isActive = true
        
        loginButton.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: LayoutConstants.bottomSpace).isActive = true
        
        loginButton.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonHeight).isActive = true
    }

}
