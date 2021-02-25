//
//  LoginProtocols.swift
//  Travelly
//
//  Created by Георгий Куликов on 26.02.2021.
//

import Foundation

protocol LoginAssemblyProtocol {
    func createModule() -> LoginViewController
}

protocol LoginPresenterProtocol {
    func goBack()
    func login()
}

protocol LoginRouterProtocol {
    func goToPreviousWindow()
    func presentUserProfile()
}

protocol LoginInteractorProtocol {
    func loginUser(email: String, password: String)
}
