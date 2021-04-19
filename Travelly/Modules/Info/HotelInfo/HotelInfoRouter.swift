//
//  HotelInfoRouter.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import UIKit

class HotelInfoRouter: HotelInfoRouterProtocol {
    
    private weak var view: HotelInfoViewController!
    
    init(view: HotelInfoViewController) {
        self.view = view
    }
    
    func goBack() {
        self.view.navigationController?.popViewController(animated: true)
    }
    
    func openAuth() {
        let assembly: AuthAssemblyProtocol = AuthAssembly()
        let authView: AuthViewController = assembly.createModule()
        authView.modalPresentationStyle = .fullScreen
        view.present(authView, animated: false, completion: nil)
    }
}
