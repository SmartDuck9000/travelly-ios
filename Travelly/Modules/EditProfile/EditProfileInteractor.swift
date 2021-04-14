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
    
    func updateProfileData(_ newProfileData: EditProfileData, complition: @escaping (Error?, Bool, Bool) -> Void) {
        networkService.put(query: "/api/users", tokens: tokens, data: newProfileData, type: .http) { (data, error, statusCode) in
            if statusCode == 401 {
                self.networkService.refreshToken(query: "api/auth", tokens: self.tokens, type: .http) { (data, error, statusCode) in
                    guard let data = data else {
                        self.dataStorage.deleteAuthData()
                        complition(error, false, true)
                        return
                    }
                    guard let authData = try? JSONDecoder().decode(AuthData.self, from: data) else {
                        self.dataStorage.deleteAuthData()
                        complition(error, false, true)
                        return
                    }
                    self.tokens = SecurityTokens(accessToken: authData.accessToken, refreshToken: authData.refreshToken)
                    self.dataStorage.update(authData: authData)
                    self.updateProfileData(newProfileData, complition: complition)
                }
            } else if statusCode == 400 {
                complition(error, true, false)
            } else {
                complition(error, false, false)
            }
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
    
    func getUrl(for image: UIImage, complition: @escaping (String?) -> Void) {
        imageHosting.getUrl(for: image) { (urlString) in
            complition(urlString)
        }
    }
    
    func loadImage(to imageView: UIImageView, with cornerRadius: CGFloat, _ placeholder: String?) {
        imageLoader.load(to: imageView, from: profileData.photoUrl, with: cornerRadius, placeholder)
    }
    
    func deleteAuthData() {
        self.dataStorage.deleteAuthData()
    }
}
