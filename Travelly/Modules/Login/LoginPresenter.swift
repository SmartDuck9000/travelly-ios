//
//  LoginPresenter.swift
//  Travelly
//
//  Created by Георгий Куликов on 26.02.2021.
//

import UIKit

class LoginPresenter: LoginPresenterProtocol {
    
    private weak var view: LoginViewController!
    private var router: LoginRouterProtocol
    private var interactor: LoginInteractorProtocol
    
    required init(view: LoginViewController, router: LoginRouterProtocol, interactor: LoginInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func goBack() {
        router.goToPreviousWindow()
    }
    
    func openProfile(userId: Int, tokens: SecurityTokens) {
        router.presentUserProfile(userId: userId, tokens: tokens)
    }
    
    func login() {
        guard let email = view.getEmail() else {
            showAuthError(message: "Для входа необходимо ввести почту")
            return
        }
        
        guard let password = view.getPassword() else {
            showAuthError(message: "Для входа необходимо ввести пароль")
            return
        }
        
        interactor.loginUser(email: email, password: password)
    }
    
    func showAuthError(message: String) {
        
    }
}
