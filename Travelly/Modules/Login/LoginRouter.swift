//
//  LoginRouter.swift
//  Travelly
//
//  Created by Георгий Куликов on 26.02.2021.
//

import UIKit

class LoginRouter: LoginRouterProtocol {
    
    private weak var view: LoginViewController!
    
    init(view: LoginViewController) {
        self.view = view
    }
    
    func goToPreviousWindow() {
        view.dismiss(animated: true, completion: nil)
    }
    
    func presentUserProfile(userId: Int, tokens: SecurityTokens) {
        let profileAssembly: ProfileAssemblyProtocol = ProfileAssembly()
        let profileView = profileAssembly.createModule(userId: userId, tokens: tokens)
        let navigationController = UINavigationController(rootViewController: profileView)
        navigationController.modalPresentationStyle = .fullScreen
        view.present(navigationController, animated: true, completion: nil)
    }
    
    func showAuthError(message: String) {
        
    }
}
