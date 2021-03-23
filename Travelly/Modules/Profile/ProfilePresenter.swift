//
//  ProfilePresenter.swift
//  Travelly
//
//  Created by Георгий Куликов on 22.03.2021.
//

import UIKit

class ProfilePresenter: ProfilePresenterProtocol {
    
    private weak var view: ProfileViewController!
    private var interactor: ProfileInteractorProtocol
    private var router: ProfileRouterProtocol
    
    init(view: ProfileViewController, router: ProfileRouterProtocol, interactor: ProfileInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func loadProfile() {
        
    }
}
