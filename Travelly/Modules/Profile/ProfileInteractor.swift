//
//  ProfileInteractor.swift
//  Travelly
//
//  Created by Георгий Куликов on 22.03.2021.
//

import UIKit

class ProfileInteractor: ProfileInteractorProtocol {
    
    private let networkService: NetworkProtocol
    private let imageLoader: ImageLoaderProtocol
    private let dataStorage: DataStorageProtocol
    
    private var tokens: SecurityTokens
    private var userId: Int
    
    init(networkService: NetworkProtocol, dataStorage: DataStorageProtocol, imageLoader: ImageLoaderProtocol, userId: Int, tokens: SecurityTokens) {
        self.networkService = networkService
        self.imageLoader = imageLoader
        self.dataStorage = dataStorage
        
        self.userId = userId
        self.tokens = tokens
    }
    
    func loadProfile(complition: @escaping (ProfileData?, Error?, Bool) -> Void) {
        networkService.get(query: "/api/users", tokens: tokens, parameters: UserIdData(userId: userId), type: .http) { (data, error, statusCode) in
            
            if statusCode == 401 {
                self.networkService.refreshToken(query: "api/auth", tokens: self.tokens, type: .http) { (data, error, statusCode) in
                    guard let data = data, let authData = try? JSONDecoder().decode(AuthData.self, from: data) else {
                        self.dataStorage.deleteFirst(type: AuthData.self)
                        complition(nil, error, true)
                        return
                    }
                    self.tokens = SecurityTokens(accessToken: authData.accessToken, refreshToken: authData.refreshToken)
                    self.dataStorage.updateFirst(entity: authData)
                    self.loadProfile(complition: complition)
                }
            }
            
            if error != nil {
                complition(nil, error, false)
                return
            }
            
            guard let data = data, let profileData = try? JSONDecoder().decode(ProfileData.self, from: data) else {
                complition(nil, error, false)
                return
            }
            
            complition(profileData, nil, false)
        }
    }
    
    func loadImage(to imageView: UIImageView, from url: String) {
        imageLoader.load(to: imageView, from: url)
    }
    
    func getTokens() -> SecurityTokens {
        return tokens
    }
    
    func getUserId() -> Int {
        return userId
    }
}
