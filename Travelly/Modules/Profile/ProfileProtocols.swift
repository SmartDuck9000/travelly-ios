//
//  UserProfileProtocols.swift
//  Travelly
//
//  Created by Георгий Куликов on 22.03.2021.
//

import UIKit

protocol ProfilePresenterProtocol {
    func loadProfile()
}

protocol ProfileInteractorProtocol {
    func loadProfile(complition: @escaping (ProfileData?, Error?, Bool) -> Void)
    func loadImage(to imageView: UIImageView, from url: String)
}

protocol ProfileRouterProtocol {
    func presentAuth()
    func showError(message: String)
}

protocol ProfileAssemblyProtocol {
    func createModule(userId: Int, tokens: SecurityTokens) -> ProfileViewController
}
