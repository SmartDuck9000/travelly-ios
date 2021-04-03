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
    func getOption(from tableView: UITableView, at index: Int) -> UITableViewCell
    func selectOption(at index: Int)
}

protocol ProfileInteractorProtocol {
    func loadProfile(complition: @escaping (ProfileData?, Error?, Bool) -> Void)
    func loadImage(to imageView: UIImageView, from url: String)
    
    func getTokens() -> SecurityTokens
    func getUserId() -> Int
}

protocol ProfileRouterProtocol {
    func openAuth()
    func showError(message: String)
    
    func getOptionsCount() -> Int
    func openEditProfileOption(with userId: Int, _ tokens: SecurityTokens)
    func openCreateTourOption(with userId: Int, _ tokens: SecurityTokens)
    func openToursOption(with userId: Int, _ tokens: SecurityTokens)
    func openAuthOption()
}

protocol ProfileAssemblyProtocol {
    func createModule(userId: Int, tokens: SecurityTokens) -> ProfileViewController
}
