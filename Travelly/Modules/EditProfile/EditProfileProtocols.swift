//
//  EditProfileProtocols.swift
//  Travelly
//
//  Created by Георгий Куликов on 02.04.2021.
//

import Foundation

protocol EditProfileAssemblyProtocol {
    func createModule(with userId: Int, _ tokens: SecurityTokens) -> EditProfileViewController
}

protocol EditProfilePresenterProtocol {
    func saveChanges()
}

protocol EditProfileInteractorProtocol {
    func updateProfileData(_ data: EditProfileData)
    func getUserId() -> Int
}

protocol EditProfileRouterProtocol {
    func closeEditProfileOption()
}
