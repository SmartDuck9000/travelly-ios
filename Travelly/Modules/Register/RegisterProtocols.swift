//
//  RegisterProtocols.swift
//  Travelly
//
//  Created by Георгий Куликов on 14.02.2021.
//

protocol RegisterAssemblyProtocol: AnyObject {
    func createModule() -> RegisterViewController
}

protocol RegisterPresenterProtocol: AnyObject {
    func goBack()
    func openProfile(userId: Int)
    func register()
    func showAuthError(message: String)
}

protocol RegisterRouterProtocol: AnyObject {
    func goToPreviousWindow()
    func presentUserProfile(userId: Int)
    func showAuthError(message: String)
}

protocol RegisterInteractorProtocol: AnyObject {
    func registerUser(email: String, password: String, firstName: String, lastName: String)
    func setPresenter(_ presenter: RegisterPresenterProtocol)
}
