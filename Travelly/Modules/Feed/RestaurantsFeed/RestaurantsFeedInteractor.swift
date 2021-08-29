//
//  RestaurantsFeedInteractor.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import UIKit

fileprivate struct DefaultFeedConstants {
    static let limit = 50
    static let offset = 0
    static let orderBy = "restaurant_name"
    static let orderType = "inc"
    static let restaurantName = ""
    static let ratingFrom = 0.0
    static let ratingTo = 5.0
    static let priceFrom = 0.0
    static let priceTo = 1000.0
    static let childMenu = false
    static let smokingRoom = false
    static let cityName = ""
}

class RestaurantsFeedInteractor: RestaurantsFeedInteractorProtocol {
    
    private let networkService: NetworkProtocol
    private let dataStorage: DataStorageProtocol
    
    private var userId: Int
    private var tokens: SecurityTokens
    
    private var restaurantsData: [RestaurantsData] = []
    private var filterData: RestaurantsFilter
    
    private var needReload = false

    init(networkService: NetworkProtocol, dataStorage: DataStorageProtocol, userId: Int, tokens: SecurityTokens) {
        self.networkService = networkService
        self.dataStorage = dataStorage
        
        self.userId = userId
        self.tokens = tokens
        
        self.filterData = RestaurantsFilter(
            limit: DefaultFeedConstants.limit,
            offset: DefaultFeedConstants.offset,
            orderBy: DefaultFeedConstants.orderBy,
            orderType: DefaultFeedConstants.orderType,
            restaurantName: DefaultFeedConstants.restaurantName,
            ratingFrom: DefaultFeedConstants.ratingFrom,
            ratingTo: DefaultFeedConstants.ratingTo,
            priceFrom: DefaultFeedConstants.priceFrom,
            priceTo: DefaultFeedConstants.priceTo,
            childMenu: DefaultFeedConstants.childMenu,
            smokingRoom: DefaultFeedConstants.smokingRoom,
            cityName: DefaultFeedConstants.cityName
        )
    }
    
    func loadFeed(complition: @escaping (Error?, Bool, Bool) -> Void) {
        if needReload {
            needReload = false
            filterData.offset = 0
            restaurantsData = []
        }
        networkService.get(query: "0.0.0.0:5004/api/feed/restaurants", tokens: tokens, parameters: filterData, type: .http) { (data, error, statusCode) in
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
                
                guard let restaurantsData = try? JSONDecoder().decode([RestaurantsData].self, from: data) else {
                    if let strData = String(data: data, encoding: .utf8) {
                        print(strData)
                    }
                    complition(error, false, false)
                    return
                }
                
                self.filterData.offset += self.filterData.limit
                self.restaurantsData += restaurantsData
                complition(nil, false, true)
            }
        }
    }
    
    func setNeedReload(_ needReload: Bool) {
        self.needReload = needReload
    }
    
    func restaurantsCount() -> Int {
        return restaurantsData.count
    }
    
    func getRestaurantsData(at index: Int) -> RestaurantsData {
        return restaurantsData[index]
    }
    
    func getTokens() -> SecurityTokens {
        return tokens
    }
    
    func deleteAuthData() {
        self.dataStorage.deleteAuthData()
    }
    
    func getRestaurantsFilterData() -> RestaurantsFilter {
        return filterData
    }
    
    func setRestaurantsFilterData(_ restaurantsFilter: RestaurantsFilter) {
        self.filterData = restaurantsFilter
    }
}
