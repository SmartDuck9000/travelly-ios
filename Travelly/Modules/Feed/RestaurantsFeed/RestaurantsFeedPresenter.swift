//
//  RestaurantsFeedPresenter.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import UIKit

class RestaurantsFeedPresenter: RestaurantsFeedPresenterProtocol, RestaurantsFilterPresenterProtocol {

    private weak var view: RestaurantsFeedViewController?
    private weak var filterView: RestaurantsFeedFilterViewController?
    private let router: RestaurantsFeedRouterProtocol
    private let interactor: RestaurantsFeedInteractorProtocol
    
    private let orderByMap: [String:String] = [
        "По названию": "restaurant_name",
        "По рейтингу": "rest_rating",
        "По цене": "avg_price"
    ]
    private let orderTypeMap: [String:String] = [
        "по возрастанию": "inc",
        "по убыванию": "dec"
    ]
    
    private let orderData: [String] = [
        "По названию, по возрастанию",
        "По названию, по убыванию",
        "По рейтингу, по возрастанию",
        "По рейтингу, по убыванию",
        "По цене, по возрастанию",
        "По цене, по убыванию"
    ]
    
    init(view: RestaurantsFeedViewController, router: RestaurantsFeedRouterProtocol, interactor: RestaurantsFeedInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func loadFeed() {
        let searchRestaurantsName = view?.getSearchRestaurantsName() ?? ""
        var filterData = interactor.getRestaurantsFilterData()
        filterData.restaurantName = searchRestaurantsName
        interactor.setRestaurantsFilterData(filterData)
        
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
        let searchRestaurantsName = view?.getSearchRestaurantsName() ?? ""
        var filterData = interactor.getRestaurantsFilterData()
        filterData.restaurantName = searchRestaurantsName
        interactor.setRestaurantsFilterData(filterData)
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
    
    func restaurantsCount() -> Int {
        if interactor.restaurantsCount() == 0 {
            return 0
        }
        return interactor.restaurantsCount() + 1
    }
    
    func configureRestaurantsCell(_ cell: RestaurantsTableViewCell, at index: Int) {
        
        if index == interactor.restaurantsCount() {
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
            let restaurantsData = interactor.getRestaurantsData(at: index)
            
            cell.setupCell()
            cell.setRestaurantName(restaurantsData.restaurantName)
            cell.setRating(restaurantsData.rating)
            cell.setCountryCityName(restaurantsData.countryName, cityName: restaurantsData.cityName)
        }
    }
    
    func selectRestaurant(at index: Int) {
        let restaurantsData = interactor.getRestaurantsData(at: index)
        router.openFullInfo(with: restaurantsData.restaurantId, interactor.getTokens())
    }
    
    func goBack() {
        router.goBack()
    }
    
    func openFilter() {
        router.openFilter(with: self)
    }
    
    func setFilterView(_ filterView: RestaurantsFeedFilterViewController) {
        self.filterView = filterView
    }
    
    func setupFilters() {
        let filterData = interactor.getRestaurantsFilterData()
        
        filterView?.setOrderData(orderData)
        var order = ""
        if let orderBy = orderByMap.first(where: { $1 == filterData.orderBy })?.key {
            order += orderBy
            if let orderType = orderTypeMap.first(where: { $1 == filterData.orderType })?.key {
                order += ", " + orderType
            }
        }
        
        filterView?.setOrder(order)
        filterView?.setRating(from: filterData.ratingFrom, to: filterData.ratingTo)
        filterView?.setPrice(from: Int(filterData.priceFrom), to: Int(filterData.priceTo))
        filterView?.setChileMenu(filterData.childMenu)
        filterView?.setSmokingRoom(filterData.smokingRoom)
        filterView?.setCityName(filterData.cityName)
    }
    
    func saveFilters() {
        var filterData = interactor.getRestaurantsFilterData()
        
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
        
        filterData.childMenu = filterView?.getChileMenu() ?? false
        filterData.smokingRoom = filterView?.getSmokingRoom() ?? false
        if let cityName = filterView?.getCityName() {
            filterData.cityName = cityName
        }
        
        interactor.setRestaurantsFilterData(filterData)
        interactor.setNeedReload(true)
    }
}
