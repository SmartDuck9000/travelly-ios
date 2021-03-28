//
//  UserProfileProtocols.swift
//  Travelly
//
//  Created by Георгий Куликов on 22.03.2021.
//

import Foundation

protocol ProfilePresenterProtocol {
    func loadProfile()
}

protocol ProfileInteractorProtocol {
    func loadProfile(complition: @escaping (ProfileData?, Error?, Bool) -> Void)
}

protocol ProfileRouterProtocol {
    func presentAuth()
    func showError(message: String)
}

protocol ProfileAssemblyProtocol {
    func createModule(userId: Int) -> ProfileViewController
}
