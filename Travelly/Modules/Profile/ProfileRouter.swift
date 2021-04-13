//
//  ProfileRouter.swift
//  Travelly
//
//  Created by Георгий Куликов on 22.03.2021.
//

import UIKit

class ProfileRouter: ProfileRouterProtocol {
    
    private var view: ProfileViewController
    
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
    
    func openEditProfile(with userId: Int, _ tokens: SecurityTokens) {
        
    }
    
    func openCreateTour(with userId: Int, _ tokens: SecurityTokens) {
        
    }
    
    func openTours(with userId: Int, _ tokens: SecurityTokens) {
        
    }
    
    func openHotels(with userId: Int, _ tokens: SecurityTokens) {
        
    }
    
    func openRestaurants(with userId: Int, _ tokens: SecurityTokens) {
        
    }
    
    func openEvents(with userId: Int, _ tokens: SecurityTokens) {
        
    }
    
    func openTickets(with userId: Int, _ tokens: SecurityTokens) {
        
    }
    
    func exit() {
        let assembly: AuthAssemblyProtocol = AuthAssembly()
        let authView: AuthViewController = assembly.createModule()
        authView.modalPresentationStyle = .fullScreen
        view.present(authView, animated: false, completion: nil)
    }
}
