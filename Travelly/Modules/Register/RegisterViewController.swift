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
        
    }
    
    private func setupEmailField() {
        
    }
    
    private func setupFirstNameField() {
        
    }
    
    private func setupLastNameField() {
        
    }
    
    private func setupRegisterButton() {
        
    }

}
