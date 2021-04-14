//
//  UserProfileProtocols.swift
//  Travelly
//
//  Created by Георгий Куликов on 22.03.2021.
//

import UIKit

protocol ProfilePresenterProtocol {
    func loadProfile()
    func optionsCount() -> Int
    func configureOptionCell(_ cell: ProfileOptionTableViewCell, at index: Int)
    func selectOption(at index: Int)
}

protocol ProfileInteractorProtocol {
    func loadProfile(complition: @escaping (ProfileData?, Error?, Bool) -> Void)
    func loadImage(to imageView: UIImageView, from url: String, with cornerRadius: CGFloat, _ placeholder: String?)
    
    func getTokens() -> SecurityTokens
    func getUserId() -> Int
    
    func getProfileData() -> ProfileData?
    func setProfileData(profileData: ProfileData)
    
    func deleteAuthData()
}

protocol OptionsInteractorProtocol {
    func optionsCount() -> Int
    func getProfileOptionData(at index: Int) -> ProfileOptionData?
}

protocol ProfileRouterProtocol {
    func openAuth()
    func showError(message: String)
    
    func openEditProfile(with userId: Int, _ tokens: SecurityTokens, _ profileData: ProfileData)
    func openCreateTour(with userId: Int, _ tokens: SecurityTokens)
    func openTours(with userId: Int, _ tokens: SecurityTokens)
    func openHotels(with userId: Int, _ tokens: SecurityTokens)
    func openRestaurants(with userId: Int, _ tokens: SecurityTokens)
    func openEvents(with userId: Int, _ tokens: SecurityTokens)
    func openTickets(with userId: Int, _ tokens: SecurityTokens)
    func exit()
}

protocol ProfileAssemblyProtocol {
    func createModule(userId: Int, tokens: SecurityTokens) -> ProfileViewController
}
