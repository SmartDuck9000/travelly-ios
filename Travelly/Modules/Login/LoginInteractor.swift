//
//  LoginInteractor.swift
//  Travelly
//
//  Created by Георгий Куликов on 26.02.2021.
//

import UIKit

class LoginInteractor: LoginInteractorProtocol {
    
    private let networkService: NetworkProtocol
    
    init(networkService: NetworkProtocol) {
        self.networkService = networkService
    }
    
    func loginUser(email: String, password: String) {
        let loginData = LoginData(email: email, password: password)
        networkService.post(query: "/api/auth/login", data: loginData, type: .https)
    }
}
