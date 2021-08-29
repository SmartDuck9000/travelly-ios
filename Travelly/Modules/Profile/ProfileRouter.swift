//
//  ProfileRouter.swift
//  Travelly
//
//  Created by Георгий Куликов on 22.03.2021.
//

import UIKit

class ProfileRouter: ProfileRouterProtocol {
    
    private weak var view: ProfileViewController!
    
    init(view: ProfileViewController) {
        self.view = view
    }
    
    func openAuth() {
        let assembly: AuthAssemblyProtocol = AuthAssembly()
        let authView: AuthViewController = assembly.createModule()
        authView.modalPresentationStyle = .fullScreen
        view.present(authView, animated: false, completion: nil)
    }
    
    func showError(message: String) {
        
    }
    
    func openEditProfile(with userId: Int, _ tokens: SecurityTokens, _ profileData: ProfileData) {
        let editProfileAssembly: EditProfileAssemblyProtocol = EditProfileAssembly()
        let editProfileView = editProfileAssembly.createModule(with: userId, tokens, profileData)
        view.navigationController?.pushViewController(editProfileView, animated: true)
    }
    
    func openTours(with userId: Int, _ tokens: SecurityTokens) {
        let toursAssembly: ToursAssemblyProtocol = ToursAssembly()
        let toursView = toursAssembly.createModule(userId: userId, tokens: tokens)
        view.navigationController?.pushViewController(toursView, animated: true)
    }
    
    func openHotels(with userId: Int, _ tokens: SecurityTokens) {
        let hotelFeedAssembly: HotelFeedAssemblyProtocol = HotelFeedAssembly()
        let hotelFeedView = hotelFeedAssembly.createModule(with: userId, tokens)
        view.navigationController?.pushViewController(hotelFeedView, animated: true)
    }
    
    func openRestaurants(with userId: Int, _ tokens: SecurityTokens) {
        let restaurantsFeedAssembly: RestaurantsFeedAssemblyProtocol = RestaurantsFeedAssembly()
        let restaurantsFeedView = restaurantsFeedAssembly.createModule(with: userId, tokens)
        view.navigationController?.pushViewController(restaurantsFeedView, animated: true)
    }
    
    func openEvents(with userId: Int, _ tokens: SecurityTokens) {
        let eventsFeedAssembly: EventsFeedAssemblyProtocol = EventsFeedAssembly()
        let eventsFeedView = eventsFeedAssembly.createModule(with: userId, tokens)
        view.navigationController?.pushViewController(eventsFeedView, animated: true)
    }
    
    func openTickets(with userId: Int, _ tokens: SecurityTokens) {
        let ticketsFeedAssembly: TicketsFeedAssemblyProtocol = TicketsFeedAssembly()
        let ticketsFeedView = ticketsFeedAssembly.createModule(with: userId, tokens)
        view.navigationController?.pushViewController(ticketsFeedView, animated: true)
    }
    
    func exit() {
        let assembly: AuthAssemblyProtocol = AuthAssembly()
        let authView: AuthViewController = assembly.createModule()
        authView.modalPresentationStyle = .fullScreen
        view.present(authView, animated: true, completion: nil)
    }
}
