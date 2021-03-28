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
        self.interactor.loadProfile { (profileData, error, needAuth) in
            if needAuth {
                self.router.presentAuth()
            }
            
            if let err = error {
                print(err.localizedDescription)
                self.router.showError(message: "")
            }
            
            guard let data = profileData else {
                self.router.showError(message: "")
                return
            }
            
            self.view.set(name: "\(data.firstName) \(data.lastName)")
            self.interactor.loadImage(to: self.view.getProfileImageView(), from: data.photoUrl)
        }
    }
}
