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
        networkService.post(query: "/api/auth/login", data: loginData, type: .http) { (data, error) in
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
                self.dataStorageService.save(dataModel: authData)
                self.presenter?.openProfile()
            }
        }
    }
    
    func setPresenter(_ presenter: LoginPresenterProtocol) {
        self.presenter = presenter
    }
}
