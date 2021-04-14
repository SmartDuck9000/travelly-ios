//
//  RegisterRouter.swift
//  Travelly
//
//  Created by Георгий Куликов on 21.02.2021.
//

import UIKit

class RegisterRouter: RegisterRouterProtocol {
    
    private weak var view: RegisterViewController!
    
    init(view: RegisterViewController) {
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
