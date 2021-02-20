//
//  RegisterPresenter.swift
//  Travelly
//
//  Created by Георгий Куликов on 14.02.2021.
//

class RegisterPresenter: RegisterPresenterProtocol {
    private weak var view: RegisterViewController!
    private var router: RegisterRouterProtocol!
    private var interactor: RegisterInteractorProtocol!
    
    required init(view: RegisterViewController, router: RegisterRouterProtocol, interactor: RegisterInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func goBack() {
        router.goToPreviousWindow()
    }
    
    func register() {
        
    }
}
