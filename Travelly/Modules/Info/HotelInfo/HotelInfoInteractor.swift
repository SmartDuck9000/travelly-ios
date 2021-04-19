//
//  HotelInfoInteractor.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import UIKit

class HotelInfoInteractor: HotelInfoInteractorProtocol {
    
    private let networkService: NetworkProtocol
    private let dataStorage: DataStorageProtocol
    
    private var hotelId: Int
    private var tokens: SecurityTokens
    
    private var hotelInfo: HotelInfo?
    
    init(networkService: NetworkProtocol, dataStorage: DataStorageProtocol, hotelId: Int, tokens: SecurityTokens) {
        self.networkService = networkService
        self.dataStorage = dataStorage
        
        self.hotelId = hotelId
        self.tokens = tokens
    }
    
    func loadInfo(complition: @escaping (Error?, Bool, HotelInfo?) -> Void) {
        let parametersData = HotelInfoData(id: hotelId)
        networkService.get(query: "0.0.0.0:5005/api/info/hotels", tokens: tokens, parameters: parametersData, type: .http) { (data, error, statusCode) in
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
                
                guard let hotelInfo = try? JSONDecoder().decode(HotelInfo.self, from: data) else {
                    if let strData = String(data: data, encoding: .utf8) {
                        print(strData)
                    }
                    complition(error, false, nil)
                    return
                }
                
                self.hotelInfo = hotelInfo
                complition(nil, false, hotelInfo)
            }
        }
    }
    
    func deleteAuth() {
        self.dataStorage.deleteAuthData()
    }
}
