//
//  RegisterInteractor.swift
//  Travelly
//
//  Created by Георгий Куликов on 21.02.2021.
//

import Foundation

class RegisterInteractor: RegisterInteractorProtocol {
    
    private weak var presenter: RegisterPresenterProtocol?
    private let networkService: NetworkProtocol
    private let dataStorage: DataStorageProtocol
    
    init(networkService: NetworkProtocol, dataStorage: DataStorageProtocol) {
        self.networkService = networkService
        self.dataStorage = dataStorage
    }
    
    func registerUser(email: String, password: String, firstName: String, lastName: String) {
        let registerData = RegisterData(email: email, password: password, firstName: firstName, lastName: lastName)
        networkService.post(query: "0.0.0.0:5002/api/auth/email_register", tokens: nil, data: registerData, type: .http) { (data, error, statusCode) in
            guard let data = data else {
                self.presenter?.showAuthError(message: "")
                return
            }
            
            if let _ = error {
                self.presenter?.showAuthError(message: "")
            } else {
                guard let authData = try? JSONDecoder().decode(AuthData.self, from: data) else {
                    print(String(data: data, encoding: .utf8) ?? "")
                    self.presenter?.showAuthError(message: "")
                    return
                }
                let tokens: SecurityTokens = SecurityTokens(accessToken: authData.accessToken, refreshToken: authData.refreshToken)
                self.dataStorage.save(authData: authData)
                self.presenter?.openProfile(userId: authData.userId, tokens: tokens)
            }
        }
    }
    
    func setPresenter(_ presenter: RegisterPresenterProtocol) {
        self.presenter = presenter
    }
}
