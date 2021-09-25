//
//  HotelFeedInteractor.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import UIKit

fileprivate struct DefaultFeedConstants {
    static let limit = 50
    static let offset = 0
    static let orderBy = "hotel_name"
    static let orderType = "inc"
    static let hotelName = ""
    static let starsFrom = 0
    static let starsTo = 5
    static let ratingFrom = 0.0
    static let ratingTo = 5.0
    static let priceFrom = 0.0
    static let priceTo = 1000.0
    static let nearSea = false
    static let cityName = ""
}

class HotelFeedInteractor: HotelFeedInteractorProtocol {
    
    private let networkService: NetworkProtocol
    private let dataStorage: DataStorageProtocol
    
    private var userId: Int
    private var tokens: SecurityTokens
    
    private var hotelsData: [HotelData] = []
    private var filterData: HotelFilter
    
    private var needReload = false

    init(networkService: NetworkProtocol, dataStorage: DataStorageProtocol, userId: Int, tokens: SecurityTokens) {
        self.networkService = networkService
        self.dataStorage = dataStorage
        
        self.userId = userId
        self.tokens = tokens
        
        self.filterData = HotelFilter(limit: DefaultFeedConstants.limit,
                                      offset: DefaultFeedConstants.offset,
                                      orderBy: DefaultFeedConstants.orderBy,
                                      orderType: DefaultFeedConstants.orderType,
                                      hotelName: DefaultFeedConstants.hotelName,
                                      starsFrom: DefaultFeedConstants.starsFrom,
                                      starsTo: DefaultFeedConstants.starsTo,
                                      ratingFrom: DefaultFeedConstants.ratingFrom,
                                      ratingTo: DefaultFeedConstants.ratingTo,
                                      priceFrom: DefaultFeedConstants.priceFrom,
                                      priceTo: DefaultFeedConstants.priceTo,
                                      nearSea: DefaultFeedConstants.nearSea,
                                      cityName: DefaultFeedConstants.cityName)
    }
    
    func loadFeed(complition: @escaping (Error?, Bool, Bool) -> Void) {
        if needReload {
            needReload = false
            filterData.offset = 0
            hotelsData = []
        }
        networkService.get(query: "0.0.0.0:5004/api/feed/hotels", tokens: tokens, parameters: filterData, type: .http) { (data, error, statusCode) in
            if statusCode == 401 {
                self.networkService.refreshToken(query: "0.0.0.0:5002/api/auth", tokens: self.tokens, type: .http) { (data, error, statusCode) in
                    guard let data = data else {
                        self.dataStorage.deleteAuthData()
                        complition(error, true, false)
                        return
                    }
                    guard let authData = try? JSONDecoder().decode(AuthData.self, from: data) else {
                        self.dataStorage.deleteAuthData()
                        complition(error, true, false)
                        return
                    }
                    self.tokens = SecurityTokens(accessToken: authData.accessToken, refreshToken: authData.refreshToken)
                    self.dataStorage.update(authData: authData)
                    self.loadFeed(complition: complition)
                }
            } else {
                if error != nil {
                    complition(error, false, false)
                    return
                }
                
                guard let data = data else {
                    complition(error, false, false)
                    return
                }
                
                guard let hotelsData = try? JSONDecoder().decode([HotelData].self, from: data) else {
                    if let strData = String(data: data, encoding: .utf8) {
                        print(strData)
                    }
                    complition(error, false, false)
                    return
                }
                
                self.filterData.offset += self.filterData.limit
                self.hotelsData += hotelsData
                complition(nil, false, true)
            }
        }
    }
    
    func setNeedReload(_ needReload: Bool) {
        self.needReload = needReload
    }
    
    func hotelsCount() -> Int {
        return hotelsData.count
    }
    
    func getHotelData(at index: Int) -> HotelData {
        return hotelsData[index]
    }
    
    func getTokens() -> SecurityTokens {
        return tokens
    }
    
    func deleteAuthData() {
        self.dataStorage.deleteAuthData()
    }
    
    func getHotelFilterData() -> HotelFilter {
        return filterData
    }
    
    func setHotelFilterData(_ hotelFilter: HotelFilter) {
        self.filterData = hotelFilter
    }
}
