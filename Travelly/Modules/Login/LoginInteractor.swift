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
    private let dataStorageService: DataStorageProtocol
    
    init(networkService: NetworkProtocol, dataStorageService: DataStorageProtocol) {
        self.networkService = networkService
        self.dataStorageService = dataStorageService
    }
    
    func loginUser(email: String, password: String) {
        let loginData = LoginData(email: email, password: password)
        networkService.post(query: "/api/auth/login", tokens: nil, data: loginData, type: .http) { (data, error, statusCode) in
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
                
                let tokens: SecurityTokens = SecurityTokens(accessToken: authData.accessToken,
                                                            refreshToken: authData.refreshToken)
                
                self.dataStorageService.save(entity: tokens)
                self.presenter?.openProfile()
            }
        }
    }
    
    func setPresenter(_ presenter: LoginPresenterProtocol) {
        self.presenter = presenter
    }
}
