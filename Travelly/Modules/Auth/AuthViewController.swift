//
//  AuthViewController.swift
//  Travelly
//
//  Created by Георгий Куликов on 16.02.2021.
//

import UIKit

fileprivate struct LayoutConstants {
    static let leftSpace = 15
    static let rightSpace = -15
    static let bottomSpace = -20
    static let betweenButtonSpace = -10
    
    static let buttonHeight = 42
}

class AuthViewController: UIViewController {
    
    private let authIconImageView = UIImageView()
    private let loginButton = UIButton()
    private let registerButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    @objc
    private func loginButtonTapped() {
        
    }
    
    @objc
    private func registerButtonTapped() {
        
    }
    
    private func setupView() {
        view.backgroundColor = AppColorAppearance.appBackgroundColor
        
        setupAuthIconImageView()
        setupLoginButton()
        setupRegisterButton()
    }
    
    private func setupAuthIconImageView() {
        view.addSubview(authIconImageView)
        authIconImageView.image = UIImage(named: "AuthImage.png")
        
        authIconImageView.translatesAutoresizingMaskIntoConstraints = false
        authIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        authIconImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.setTitle("Войти", for: .normal)
        loginButton.setTitleColor(MainButtonAppearance.textColor, for: .normal)
        loginButton.titleLabel?.font = UIFont(name: MainButtonAppearance.fontName, size: MainButtonAppearance.fontSize)
        
        loginButton.backgroundColor = MainButtonAppearance.backgroundColor
        loginButton.layer.cornerRadius = view.safeAreaLayoutGuide.layoutFrame.size.width * MainButtonAppearance.cornerRadiusRatio
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: CGFloat(LayoutConstants.leftSpace)).isActive = true
        
        loginButton.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: CGFloat(LayoutConstants.rightSpace)).isActive = true
        
        loginButton.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: CGFloat(LayoutConstants.bottomSpace)).isActive = true
        
        loginButton.heightAnchor.constraint(equalToConstant: CGFloat(LayoutConstants.buttonHeight)).isActive = true
    }
    
    private func setupRegisterButton() {
        view.addSubview(registerButton)
        
        registerButton.setTitle("Зарегестрироваться", for: .normal)
        registerButton.setTitleColor(SpecialButtonAppearance.textColor, for: .normal)
        loginButton.titleLabel?.font = UIFont(name: SpecialButtonAppearance.fontName, size: SpecialButtonAppearance.fontSize)
        
        registerButton.backgroundColor = SpecialButtonAppearance.backgroundColor
        registerButton.layer.cornerRadius = view.safeAreaLayoutGuide.layoutFrame.size.width * SpecialButtonAppearance.cornerRadiusRatio
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        registerButton.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: CGFloat(LayoutConstants.leftSpace)).isActive = true
        
        registerButton.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: CGFloat(LayoutConstants.rightSpace)).isActive = true
        
        registerButton.bottomAnchor.constraint(
            equalTo: loginButton.topAnchor,
            constant: CGFloat(LayoutConstants.betweenButtonSpace)).isActive = true
        
        registerButton.heightAnchor.constraint(equalToConstant: CGFloat(LayoutConstants.buttonHeight)).isActive = true
    }
}
