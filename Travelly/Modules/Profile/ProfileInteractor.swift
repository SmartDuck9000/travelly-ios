//
//  ProfileInteractor.swift
//  Travelly
//
//  Created by Георгий Куликов on 22.03.2021.
//

import UIKit

class ProfileInteractor: ProfileInteractorProtocol {
    
    private var networkService: NetworkProtocol
    private var dataStorageService: DataStorageProtocol
    private var tokens: SecurityTokens?
    private var userId: Int
    
    init(networkService: NetworkProtocol, dataStorageService: DataStorageProtocol, userId: Int) {
        self.networkService = networkService
        self.dataStorageService = dataStorageService
        self.userId = userId
        
        self.tokens = dataStorageService.getFirst(type: SecurityTokens.self)
    }
    
    func loadProfile(complition: @escaping (ProfileData?, Error?, Bool) -> Void) {
        networkService.get(query: "/api/users", tokens: tokens, parameters: UserIdData(userId: userId), type: .http) { (data, error, statusCode) in
            
            if statusCode == 401 {
                if let tokens = self.tokens {
                    self.networkService.refreshToken(query: "api/auth", tokens: tokens, type: .http) { (data, error, statusCode) in
                        guard let data = data, let authData = try? JSONDecoder().decode(AuthData.self, from: data) else {
                            self.dataStorageService.deleteFirst(type: SecurityTokens.self)
                            complition(nil, error, true)
                            return
                        }
                        let tokens: SecurityTokens = SecurityTokens(accessToken: authData.accessToken,
                                                                    refreshToken: authData.refreshToken)
                        
                        self.dataStorageService.updateFirst(entity: tokens)
                        self.loadProfile(complition: complition)
                    }
                } else {
                    self.dataStorageService.deleteFirst(type: SecurityTokens.self)
                    complition(nil, error, true)
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
}
