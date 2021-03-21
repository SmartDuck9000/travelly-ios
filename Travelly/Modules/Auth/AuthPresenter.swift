//
//  AuthPresenter.swift
//  Travelly
//
//  Created by Георгий Куликов on 16.02.2021.
//

import Foundation


class AuthPresenter: AuthPresenterProtocol {
    private weak var view: AuthViewController!
    private var router: AuthRouterProtocol
    
    init(view: AuthViewController, router: AuthRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func login() {
        router.presentLoginWindow()
    }
    
    func register() {
        router.presentRegisterWindow()
    }
}
