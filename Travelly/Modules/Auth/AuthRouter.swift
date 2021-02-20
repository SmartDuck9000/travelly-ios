//
//  AuthRouter.swift
//  Travelly
//
//  Created by Георгий Куликов on 16.02.2021.
//

import Foundation

class AuthRouter: AuthRouterProtocol {
    
    private weak var view: AuthViewController!
    
    init(view: AuthViewController) {
        self.view = view
    }
    
    func presentLoginWindow() {
        let loginView = LoginViewController()
        loginView.modalPresentationStyle = .fullScreen
        
        self.view.present(loginView, animated: true, completion: nil)
    }
    
    func presentRegisterWindow() {
        let registerView = RegisterViewController()
        registerView.modalPresentationStyle = .fullScreen
        
        self.view.present(registerView, animated: true, completion: nil)
    }
}
