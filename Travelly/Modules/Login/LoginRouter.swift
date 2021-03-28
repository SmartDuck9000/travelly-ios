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
    
    func presentUserProfile(userId: Int) {
        let profileAssembly: ProfileAssemblyProtocol = ProfileAssembly()
        let profileView: ProfileViewController = profileAssembly.createModule(userId: userId)
        view.present(profileView, animated: true, completion: nil)
    }
    
    func showAuthError(message: String) {
        
    }
}
