//
//  EditProfileInteractor.swift
//  Travelly
//
//  Created by Георгий Куликов on 03.04.2021.
//

import UIKit

class EditProfileInteractor: EditProfileInteractorProtocol {
    
    private var networkService: NetworkProtocol
    private var imageLoader: ImageLoaderProtocol
    
    private var userId: Int
    private var tokens: SecurityTokens
    
    init(networkService: NetworkProtocol, imageLoader: ImageLoaderProtocol, userId: Int, tokens: SecurityTokens) {
        self.networkService = networkService
        self.imageLoader = imageLoader
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
