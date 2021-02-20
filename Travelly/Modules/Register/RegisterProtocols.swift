//
//  RegisterProtocols.swift
//  Travelly
//
//  Created by Георгий Куликов on 14.02.2021.
//

protocol RegisterAssemblyProtocol {
    func createModule() -> RegisterViewController
}

protocol RegisterPresenterProtocol {
    func goBack()
    func register()
}

protocol RegisterRouterProtocol {
    func goToPreviousWindow()
    func presentUserProfile()
    func presentRegistrationError()
}

protocol RegisterInteractorProtocol {
    func registerUser(email: String, firstName: String, lastName: String)
}
