//
//  HotelFeedPresenter.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import UIKit

class HotelFeedPresenter: HotelFeedPresenterProtocol, HotelFilterPresenterProtocol {

    private weak var view: HotelFeedViewController?
    private weak var filterView: HotelFeedFilterViewController?
    private let router: HotelFeedRouterProtocol
    private let interactor: HotelFeedInteractorProtocol
    
    private let orderByMap: [String:String] = [
        "По названию": "hotel_name",
        "По звездам": "stars",
        "По рейтингу": "hotel_rating",
        "По цене": "avg_price"
    ]
    private let orderTypeMap: [String:String] = [
        "по возрастанию": "inc",
        "по убыванию": "dec"
    ]
    
    private let orderData: [String] = [
        "По названию, по возрастанию",
        "По названию, по убыванию",
        "По звездам, по возрастанию",
        "По звездам, по убыванию",
        "По рейтингу, по возрастанию",
        "По рейтингу, по убыванию",
        "По цене, по возрастанию",
        "По цене, по убыванию"
    ]
    
    init(view: HotelFeedViewController, router: HotelFeedRouterProtocol, interactor: HotelFeedInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func loadFeed() {
        let searchHotelName = view?.getSearchHotelName() ?? ""
        var filterData = interactor.getHotelFilterData()
        filterData.hotelName = searchHotelName
        interactor.setHotelFilterData(filterData)
        
        interactor.loadFeed { (error, needAuth, needReload) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            if needAuth {
                self.interactor.deleteAuthData()
                self.router.openAuth()
            }
            
            self.view?.reloadFeed()
        }
    }
    
    func reloadFeed() {
        let searchHotelName = view?.getSearchHotelName() ?? ""
        var filterData = interactor.getHotelFilterData()
        filterData.hotelName = searchHotelName
        interactor.setHotelFilterData(filterData)
        interactor.setNeedReload(true)
        
        interactor.loadFeed { (error, needAuth, needReload) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            if needAuth {
                self.interactor.deleteAuthData()
                self.router.openAuth()
            }
            
            self.view?.reloadFeed()
        }
    }
    
    func hotelsCount() -> Int {
        if interactor.hotelsCount() == 0 {
            return 0
        }
        return interactor.hotelsCount() + 1
    }
    
    func configureHotelCell(_ cell: HotelTableViewCell, at index: Int) {
        
        if index == interactor.hotelsCount() {
            interactor.loadFeed { (error, needAuth, needReload) in
                if let err = error {
                    print(err.localizedDescription)
                    return
                }

                if needAuth {
                    self.interactor.deleteAuthData()
                    self.router.openAuth()
                }
                
                if needReload {
                    self.view?.reloadFeed()
                }
            }
        } else {
            let hotelData = interactor.getHotelData(at: index)
            
            cell.setupCell()
            cell.setHotelName(hotelData.hotelName)
            cell.setStars(hotelData.stars)
            cell.setRating(hotelData.hotelRating)
            cell.setCountryCityName(hotelData.countryName, cityName: hotelData.cityName)
        }
    }
    
    func selectHotel(at index: Int) {
        let hotelData = interactor.getHotelData(at: index)
        router.openFullInfo(with: hotelData.hotelId, interactor.getTokens())
    }
    
    func goBack() {
        router.goBack()
    }
    
    func openFilter() {
        router.openFilter(with: self)
    }
    
    func setFilterView(_ filterView: HotelFeedFilterViewController) {
        self.filterView = filterView
    }
    
    func setupFilters() {
        let filterData = interactor.getHotelFilterData()
        
        filterView?.setOrderData(orderData)
        var order = ""
        if let orderBy = orderByMap.first(where: { $1 == filterData.orderBy })?.key {
            order += orderBy
            if let orderType = orderTypeMap.first(where: { $1 == filterData.orderType })?.key {
                order += ", " + orderType
            }
        }
        filterView?.setOrder(order)
        filterView?.setStars(from: filterData.starsFrom, to: filterData.starsTo)
        filterView?.setRating(from: filterData.ratingFrom, to: filterData.ratingTo)
        filterView?.setPrice(from: Int(filterData.priceFrom), to: Int(filterData.priceTo))
        filterView?.setNearSea(filterData.nearSea)
        filterView?.setCityName(filterData.cityName)
    }
    
    func saveFilters() {
        var filterData = interactor.getHotelFilterData()
        
        if let order = filterView?.getOrder() {
            var orderParts = order.split(separator: ",")
            if orderParts.count == 2 {
                orderParts[1].removeFirst()
                if let orderBy = orderByMap[String(orderParts[0])] {
                    filterData.orderBy = orderBy
                }
                if let orderType = orderTypeMap[String(orderParts[1])] {
                    filterData.orderType = orderType
                }
            }
        }
        
        if let starsFrom = filterView?.getStarsFrom() {
            filterData.starsFrom = starsFrom
        }
        
        if let starsTo = filterView?.getStarsTo() {
            filterData.starsTo = starsTo
        }
        
        if let ratingFrom = filterView?.getRatingFrom() {
            filterData.ratingFrom = ratingFrom
        }
        
        if let ratingTo = filterView?.getRatingTo() {
            filterData.ratingTo = ratingTo
        }
        
        if let priceFrom = filterView?.getPriceFrom() {
            filterData.priceFrom = Double(priceFrom)
        }
        
        if let priceTo = filterView?.getPriceTo() {
            filterData.priceTo = Double(priceTo)
        }
        
        filterData.nearSea = filterView?.getNearSea() ?? false
        if let cityName = filterView?.getCityName() {
            filterData.cityName = cityName
        }
        
        interactor.setHotelFilterData(filterData)
        interactor.setNeedReload(true)
    }
}
