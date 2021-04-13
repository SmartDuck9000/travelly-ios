//
//  LoginInteractor.swift
//  Travelly
//
//  Created by Георгий Куликов on 26.02.2021.
//

import UIKit

class LoginInteractor: LoginInteractorProtocol {
    
    private weak var presenter: LoginPresenterProtocol?
    private let networkService: NetworkProtocol
    private let dataStorage: DataStorageProtocol
    
    init(networkService: NetworkProtocol, dataStorage: DataStorageProtocol) {
        self.networkService = networkService
        self.dataStorage = dataStorage
    }
    
    func loginUser(email: String, password: String) {
        let loginData = LoginData(email: email, password: password)
        networkService.post(query: "0.0.0.0:5002/api/auth/login", tokens: nil, data: loginData, type: .http) { (data, error, statusCode) in
            guard let data = data else {
                self.presenter?.showAuthError(message: "")
                return
            }
            
            if let _ = error {
                self.presenter?.showAuthError(message: "")
            } else {
                guard let authData = try? JSONDecoder().decode(AuthData.self, from: data) else {
                    self.presenter?.showAuthError(message: "")
                    return
                }
                
                let tokens: SecurityTokens = SecurityTokens(accessToken: authData.accessToken, refreshToken: authData.refreshToken)
                self.dataStorage.save(authData: authData)
                self.presenter?.openProfile(userId: authData.userId, tokens: tokens)
            }
        }
    }
    
    func setPresenter(_ presenter: LoginPresenterProtocol) {
        self.presenter = presenter
    }
}
