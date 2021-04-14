//
//  EditProfileInteractor.swift
//  Travelly
//
//  Created by Георгий Куликов on 03.04.2021.
//

import UIKit

class EditProfileInteractor: EditProfileInteractorProtocol {
    
    private let networkService: NetworkProtocol
    private let imageLoader: ImageLoaderProtocol
    private let imageHosting: ImageHostingServiceProtocol
    private let dataStorage: DataStorageProtocol
    
    private var userId: Int
    private var tokens: SecurityTokens
    
    private var profileData: ProfileData
    
    init(networkService: NetworkProtocol, dataStorage: DataStorageProtocol, imageLoader: ImageLoaderProtocol, imageHosting: ImageHostingServiceProtocol, userId: Int, tokens: SecurityTokens, profileData: ProfileData) {
        self.networkService = networkService
        self.imageLoader = imageLoader
        self.imageHosting = imageHosting
        self.dataStorage = dataStorage
        
        self.userId = userId
        self.tokens = tokens
        
        self.profileData = profileData
    }
    
    func updateProfileData(_ data: EditProfileData) {
        networkService.put(query: "/api/users", tokens: tokens, data: data, type: .http) { (data, error, code) in
            
        }
    }
    
    func getUserId() -> Int {
        return userId
    }
    
    func getFirstName() -> String {
        return profileData.firstName
    }
    
    func getLastName() -> String {
        return profileData.lastName
    }
    
    func getUrl(for image: UIImage) -> String {
        return imageHosting.getUrl(for: image)
    }
    
    func loadImage(to imageView: UIImageView, with cornerRadius: CGFloat, _ placeholder: String?) {
        imageLoader.load(to: imageView, from: profileData.photoUrl, with: cornerRadius, placeholder)
    }
}
