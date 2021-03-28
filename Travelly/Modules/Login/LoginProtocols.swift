//
//  LoginProtocols.swift
//  Travelly
//
//  Created by Георгий Куликов on 26.02.2021.
//

import Foundation

protocol LoginAssemblyProtocol: AnyObject {
    func createModule() -> LoginViewController
}

protocol LoginPresenterProtocol: AnyObject {
    func goBack()
    func openProfile(userId: Int, tokens: SecurityTokens)
    func login()
    func showAuthError(message: String)
}

protocol LoginRouterProtocol: AnyObject {
    func goToPreviousWindow()
    func presentUserProfile(userId: Int, tokens: SecurityTokens)
    func showAuthError(message: String)
}

protocol LoginInteractorProtocol: AnyObject {
    func loginUser(email: String, password: String)
    func setPresenter(_ presenter: LoginPresenterProtocol)
}
