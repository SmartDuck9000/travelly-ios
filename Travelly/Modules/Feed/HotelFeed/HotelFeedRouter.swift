//
//  HotelFeedRouter.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import UIKit

class HotelFeedRouter: HotelFeedRouterProtocol {
    private weak var view: HotelFeedViewController!
    
    init(view: HotelFeedViewController) {
        self.view = view
    }
    
    func goBack() {
        view.navigationController?.popViewController(animated: true)
    }
    
    func openFullInfo(with id: Int, _ tokens: SecurityTokens) {
        
    }
    
    func openAuth() {
        let assembly: AuthAssemblyProtocol = AuthAssembly()
        let authView: AuthViewController = assembly.createModule()
        authView.modalPresentationStyle = .fullScreen
        view.present(authView, animated: false, completion: nil)
    }
}
