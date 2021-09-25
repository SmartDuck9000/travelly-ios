//
//  TicketInfoInteractor.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import UIKit

class TicketInfoInteractor: TicketInfoInteractorProtocol {
    
    private let networkService: NetworkProtocol
    private let dataStorage: DataStorageProtocol
    
    private var ticketId: Int
    private var tokens: SecurityTokens
    
    private var ticketInfo: TicketInfo?
    
    init(networkService: NetworkProtocol, dataStorage: DataStorageProtocol, ticketId: Int, tokens: SecurityTokens) {
        self.networkService = networkService
        self.dataStorage = dataStorage
        
        self.ticketId = ticketId
        self.tokens = tokens
    }
    
    func loadInfo(complition: @escaping (Error?, Bool, TicketInfo?) -> Void) {
        let parametersData = TicketInfoData(id: ticketId)
        networkService.get(query: "0.0.0.0:5005/api/info/tickets", tokens: tokens, parameters: parametersData, type: .http) { (data, error, statusCode) in
            if statusCode == 401 {
                self.networkService.refreshToken(query: "0.0.0.0:5002/api/auth", tokens: self.tokens, type: .http) { (data, error, statusCode) in
                    guard let data = data else {
                        self.dataStorage.deleteAuthData()
                        complition(error, true, nil)
                        return
                    }
                    guard let authData = try? JSONDecoder().decode(AuthData.self, from: data) else {
                        self.dataStorage.deleteAuthData()
                        complition(error, true, nil)
                        return
                    }
                    self.tokens = SecurityTokens(accessToken: authData.accessToken, refreshToken: authData.refreshToken)
                    self.dataStorage.update(authData: authData)
                    self.loadInfo(complition: complition)
                }
            } else {
                if error != nil {
                    complition(error, false, nil)
                    return
                }
                
                guard let data = data else {
                    complition(error, false, nil)
                    return
                }
                
                guard let ticketInfo = try? JSONDecoder().decode(TicketInfo.self, from: data) else {
                    if let strData = String(data: data, encoding: .utf8) {
                        print(strData)
                    }
                    complition(error, false, nil)
                    return
                }
                
                self.ticketInfo = ticketInfo
                complition(nil, false, ticketInfo)
            }
        }
    }
    
    func deleteAuth() {
        self.dataStorage.deleteAuthData()
    }
}
