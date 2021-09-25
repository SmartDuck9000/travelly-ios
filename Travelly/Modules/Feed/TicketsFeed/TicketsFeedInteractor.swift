//
//  TicketsFeedInteractor.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import UIKit

fileprivate struct DefaultFeedConstants {
    static let limit = 50
    static let offset = 0
    static let orderBy = "price"
    static let orderType = "inc"
    static let transportType = ""
    static let dateFrom = ""
    static let dateTo = ""
    static let priceFrom = 0.0
    static let priceTo = 1000.0
    static let cityName = ""
}

class TicketsFeedInteractor: TicketsFeedInteractorProtocol {
    
    private let networkService: NetworkProtocol
    private let dataStorage: DataStorageProtocol
    
    private var userId: Int
    private var tokens: SecurityTokens
    
    private var ticketsData: [TicketsData] = []
    private var filterData: TicketsFilter
    
    private var needReload = false

    init(networkService: NetworkProtocol, dataStorage: DataStorageProtocol, userId: Int, tokens: SecurityTokens) {
        self.networkService = networkService
        self.dataStorage = dataStorage
        
        self.userId = userId
        self.tokens = tokens
        
        self.filterData = TicketsFilter(
            limit: DefaultFeedConstants.limit,
            offset: DefaultFeedConstants.offset,
            orderBy: DefaultFeedConstants.orderBy,
            orderType: DefaultFeedConstants.orderType,
            transportType: DefaultFeedConstants.transportType,
            dateFrom: DefaultFeedConstants.dateFrom,
            dateTo: DefaultFeedConstants.dateTo,
            priceFrom: DefaultFeedConstants.priceFrom,
            priceTo: DefaultFeedConstants.priceTo,
            origCityName: DefaultFeedConstants.cityName,
            destCityName: DefaultFeedConstants.cityName
        )
    }
    
    func loadFeed(complition: @escaping (Error?, Bool, Bool) -> Void) {
        if needReload {
            needReload = false
            filterData.offset = 0
            ticketsData = []
        }
        networkService.get(query: "0.0.0.0:5004/api/feed/tickets", tokens: tokens, parameters: filterData, type: .http) { (data, error, statusCode) in
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
                
                guard let ticketsData = try? JSONDecoder().decode([TicketsData].self, from: data) else {
                    if let strData = String(data: data, encoding: .utf8) {
                        print(strData)
                    }
                    complition(error, false, false)
                    return
                }
                
                self.filterData.offset += self.filterData.limit
                self.ticketsData += ticketsData
                complition(nil, false, true)
            }
        }
    }
    
    func setNeedReload(_ needReload: Bool) {
        self.needReload = needReload
    }
    
    func ticketsCount() -> Int {
        return ticketsData.count
    }
    
    func getTicketsData(at index: Int) -> TicketsData {
        return ticketsData[index]
    }
    
    func getTokens() -> SecurityTokens {
        return tokens
    }
    
    func deleteAuthData() {
        self.dataStorage.deleteAuthData()
    }
    
    func getTicketsFilterData() -> TicketsFilter {
        return filterData
    }
    
    func setTicketsFilterData(_ hotelFilter: TicketsFilter) {
        self.filterData = hotelFilter
    }
}
