//
//  ProfileRouter.swift
//  Travelly
//
//  Created by Георгий Куликов on 22.03.2021.
//

import UIKit

class ProfileRouter: ProfileRouterProtocol {
    private var view: ProfileViewController
    private var optionsCount = 4
    
    init(view: ProfileViewController) {
        self.view = view
    }
    
    func openAuth() {
        let assembly: AuthAssemblyProtocol = AuthAssembly()
        let authView: AuthViewController = assembly.createModule()
        view.present(authView, animated: false, completion: nil)
    }
    
    func showError(message: String) {
        
    }
    
    func getOptionsCount() -> Int {
        return optionsCount
    }
    
    func openEditProfileOption(with userId: Int, _ tokens: SecurityTokens) {
        
    }
    
    func openCreateTourOption(with userId: Int, _ tokens: SecurityTokens) {
        
    }
    
    func openToursOption(with userId: Int, _ tokens: SecurityTokens) {
        
    }
    
    func openAuthOption() {
        let assembly: AuthAssemblyProtocol = AuthAssembly()
        let authView: AuthViewController = assembly.createModule()
        view.present(authView, animated: false, completion: nil)
    }
}
