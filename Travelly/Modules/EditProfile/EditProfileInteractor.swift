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
    private let dataStorage: DataStorageProtocol
    
    private var userId: Int
    private var tokens: SecurityTokens
    
    init(networkService: NetworkProtocol, dataStorage: DataStorageProtocol, imageLoader: ImageLoaderProtocol, userId: Int, tokens: SecurityTokens) {
        self.networkService = networkService
        self.imageLoader = imageLoader
        self.dataStorage = dataStorage
        
        self.userId = userId
        self.tokens = tokens
    }
    
    func updateProfileData(_ data: EditProfileData) {
        networkService.put(query: "/api/users", tokens: tokens, data: data, type: .http) { (data, error, code) in
            
        }
    }
    
    func getUserId() -> Int {
        return userId
    }
}
