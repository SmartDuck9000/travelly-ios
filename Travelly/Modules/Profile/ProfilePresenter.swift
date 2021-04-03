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
                self.router.openAuth()
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
    
    func optionsCount() -> Int {
        return router.getOptionsCount()
    }
    
    func getOption(from tableView: UITableView, at index: Int) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func selectOption(at index: Int) {
        let userId = interactor.getUserId()
        let tokens = interactor.getTokens()
        
        switch index {
        case 0:
            router.openEditProfileOption(with: userId, tokens)
        case 1:
            router.openCreateTourOption(with: userId, tokens)
        case 2:
            router.openToursOption(with: userId, tokens)
        case 3:
            router.openAuthOption()
        default:
            print("No option at index: \(index)")
        }
    }
}
