//
//  RegisterPresenter.swift
//  Travelly
//
//  Created by Георгий Куликов on 14.02.2021.
//

class RegisterPresenter: RegisterPresenterProtocol {
    private weak var view: RegisterViewController!
    private var router: RegisterRouterProtocol
    private var interactor: RegisterInteractorProtocol
    
    required init(view: RegisterViewController, router: RegisterRouterProtocol, interactor: RegisterInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func goBack() {
        router.goToPreviousWindow()
    }
    
    func register() {
        guard let firstName = view.getFirstName() else {
            showAuthError(message: "Для регистрации необходимо ввести имя")
            return
        }
        
        guard let lastName = view.getLastName() else {
            showAuthError(message: "Для регистрации необходимо ввести фамилию")
            return
        }
        
        guard let email = view.getEmail() else {
            showAuthError(message: "Для регистрации необходимо ввести почту")
            return
        }
        
        guard let password = view.getPassword() else {
            showAuthError(message: "Для регистрации необходимо ввести пароль")
            return
        }
        
        interactor.registerUser(email: email, password: password, firstName: firstName, lastName: lastName)
    }
    
    func openProfile(userId: Int) {
        router.presentUserProfile(userId: userId)
    }
    
    func showAuthError(message: String) {
        
    }
}
