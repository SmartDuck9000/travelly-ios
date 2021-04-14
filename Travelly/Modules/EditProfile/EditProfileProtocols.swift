//
//  EditProfileProtocols.swift
//  Travelly
//
//  Created by Георгий Куликов on 02.04.2021.
//

import UIKit

protocol EditProfileAssemblyProtocol {
    func createModule(with userId: Int, _ tokens: SecurityTokens, _ profileData: ProfileData) -> EditProfileViewController
}

protocol EditProfilePresenterProtocol {
    func setupProfileData()
    func goBack()
    func saveChanges()
}

protocol EditProfileInteractorProtocol {
    func updateProfileData(_ data: EditProfileData)
    func getUserId() -> Int
    
    func getFirstName() -> String
    func getLastName() -> String
    func getUrl(for image: UIImage, complition: @escaping (String?) -> Void)
    func loadImage(to imageView: UIImageView, with cornerRadius: CGFloat, _ placeholder: String?)
}

protocol EditProfileRouterProtocol {
    func showError(message: String)
    func closeEditProfileOption()
}
