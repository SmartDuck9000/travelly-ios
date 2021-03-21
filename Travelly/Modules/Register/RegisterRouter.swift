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
    
    func presentUserProfile() {
        
    }
    
    func showAuthError(message: String) {
        
    }
}
