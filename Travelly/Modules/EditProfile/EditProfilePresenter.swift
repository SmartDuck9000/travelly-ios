//
//  EditProfilePresenter.swift
//  Travelly
//
//  Created by Георгий Куликов on 03.04.2021.
//

import UIKit

class EditProfilePresenter: EditProfilePresenterProtocol {
    
    private weak var view: EditProfileViewController!
    private var router: EditProfileRouterProtocol
    private var interactor: EditProfileInteractorProtocol
    
    init(view: EditProfileViewController, router: EditProfileRouterProtocol, interactor: EditProfileInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func saveChanges() {
        
    }
}
