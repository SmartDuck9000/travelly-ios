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
        networkService.get(query: "0.0.0.0:5001/api/users", tokens: tokens, parameters: UserIdData(userId: userId), type: .http) { (data, error, statusCode) in
            
            if statusCode == 401 {
                self.networkService.refreshToken(query: "api/auth", tokens: self.tokens, type: .http) { (data, error, statusCode) in
                    guard let data = data, let authData = try? JSONDecoder().decode(AuthData.self, from: data) else {
                        self.dataStorage.deleteAuthData()
                        complition(nil, error, true)
                        return
                    }
                    self.tokens = SecurityTokens(accessToken: authData.accessToken, refreshToken: authData.refreshToken)
                    self.dataStorage.update(authData: authData)
                    self.loadProfile(complition: complition)
                }
            } else {
                if error != nil {
                    complition(nil, error, false)
                    return
                }
                
                guard let data = data else {
                    complition(nil, error, false)
                    return
                }
                
                guard let profileData = try? JSONDecoder().decode(ProfileData.self, from: data) else {
                    if let strData = String(data: data, encoding: .utf8) {
                        print(strData)
                    }
                    complition(nil, error, false)
                    return
                }
                
                complition(profileData, nil, false)
            }
        }
    }
    
    func loadImage(to imageView: UIImageView, from url: String, with cornerRadius: CGFloat, _ placeholder: String? = nil) {
        imageLoader.load(to: imageView, from: url, with: cornerRadius, placeholder)
    }
    
    func getTokens() -> SecurityTokens {
        return tokens
    }
    
    func getUserId() -> Int {
        return userId
    }
}
