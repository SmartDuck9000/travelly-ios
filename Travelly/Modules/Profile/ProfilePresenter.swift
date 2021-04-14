//
//  ProfilePresenter.swift
//  Travelly
//
//  Created by Георгий Куликов on 22.03.2021.
//

import UIKit

class ProfilePresenter: ProfilePresenterProtocol {
    
    private weak var view: ProfileViewController!
    private var profileInteractor: ProfileInteractorProtocol
    private var optionsInteractor: OptionsInteractorProtocol
    private var router: ProfileRouterProtocol
    
    init(view: ProfileViewController, router: ProfileRouterProtocol, profileInteractor: ProfileInteractorProtocol, optionsInteractor: OptionsInteractorProtocol) {
        self.view = view
        self.profileInteractor = profileInteractor
        self.optionsInteractor = optionsInteractor
        self.router = router
    }
    
    func loadProfile() {
        self.profileInteractor.loadProfile { (profileData, error, needAuth) in
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
            let imageSize: CGFloat = self.view.getProfileImageSize()
            self.profileInteractor.loadImage(to: self.view.getProfileImageView(), from: data.photoUrl, with: imageSize / 2, "ImagePlaceholder")
            
            self.profileInteractor.setProfileData(profileData: data)
        }
    }
    
    func optionsCount() -> Int {
        return optionsInteractor.optionsCount()
    }
    
    func configureOptionCell(_ cell: ProfileOptionTableViewCell, at index: Int) {
        guard let optionData = optionsInteractor.getProfileOptionData(at: index) else { return }
        cell.setOptionName(optionData.name)
        cell.setupCell()
        
        switch index {
        case 0:
            cell.setImage(UIImage(named: "EditImage"))
        case 1:
            cell.setImage(UIImage(named: "AddImage"))
        case 2:
            cell.setImage(UIImage(named: "MyToursImage"))
        case 3:
            cell.setImage(UIImage(named: "HotelImage"))
        case 4:
            cell.setImage(UIImage(named: "RestaurantImage"))
        case 5:
            cell.setImage(UIImage(named: "EventImage"))
        case 6:
            cell.setImage(UIImage(named: "TicketImage"))
        case 7:
            cell.setImage(UIImage(named: "ExitImage"))
            cell.setTextColor(.red)
        default:
            print("No option at index: \(index)")
        }
    }
    
    func selectOption(at index: Int) {
        let userId = profileInteractor.getUserId()
        let tokens = profileInteractor.getTokens()
        
        switch index {
        case 0:
            guard let profileData = profileInteractor.getProfileData() else { return }
            router.openEditProfile(with: userId, tokens, profileData)
        case 1:
            router.openCreateTour(with: userId, tokens)
        case 2:
            router.openTours(with: userId, tokens)
        case 3:
            router.openHotels(with: userId, tokens)
        case 4:
            router.openRestaurants(with: userId, tokens)
        case 5:
            router.openEvents(with: userId, tokens)
        case 6:
            router.openTickets(with: userId, tokens)
        case 7:
            profileInteractor.deleteAuthData()
            router.exit()
        default:
            print("No option at index: \(index)")
        }
    }
}
