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
    func loadProfile(complition: @escaping (ProfileData?, Error?) -> Void)
}

protocol ProfileRouterProtocol {
    
}

protocol ProfileAssemblyProtocol {
    func createModule(userId: Int) -> ProfileViewController
}
