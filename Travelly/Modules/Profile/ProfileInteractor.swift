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
    
    func loadProfile(complition: @escaping (ProfileData?, Error?) -> Void) {
        
    }
}
