//
//  EventsFeedPresenter.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import UIKit

class EventsFeedPresenter: EventsFeedPresenterProtocol, EventsFilterPresenterProtocol {

    private weak var view: EventsFeedViewController?
    private weak var filterView: EventsFeedFilterViewController?
    private let router: EventsFeedRouterProtocol
    private let interactor: EventsFeedInteractorProtocol
    
    private let orderByMap: [String:String] = [
        "По названию": "event_name",
        "По рейтингу": "event_rating",
        "По цене": "event_price"
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
    
    init(view: EventsFeedViewController, router: EventsFeedRouterProtocol, interactor: EventsFeedInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func loadFeed() {
        let searchEventsName = view?.getSearchEventsName() ?? ""
        var filterData = interactor.getEventsFilterData()
        filterData.eventName = searchEventsName
        interactor.setEventsFilterData(filterData)
        
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
        let searchEventsName = view?.getSearchEventsName() ?? ""
        var filterData = interactor.getEventsFilterData()
        filterData.eventName = searchEventsName
        interactor.setEventsFilterData(filterData)
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
    
    func eventsCount() -> Int {
        if interactor.eventsCount() == 0 {
            return 0
        }
        return interactor.eventsCount() + 1
    }
    
    func configureEventsCell(_ cell: EventsTableViewCell, at index: Int) {
        
        if index == interactor.eventsCount() {
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
            let eventsData = interactor.getEventsData(at: index)
            
            cell.setupCell()
            cell.setEventName(eventsData.eventName)
            cell.setEventStartLabel(eventsData.eventStart)
            cell.setEventEndLabel(eventsData.eventEnd)
            cell.setRating(eventsData.rating)
            cell.setCountryCityName(eventsData.countryName, cityName: eventsData.cityName)
            cell.setMaxPersons(Int(eventsData.maxPersons))
        }
    }
    
    func selectEvent(at index: Int) {
        let eventData = interactor.getEventsData(at: index)
        router.openFullInfo(with: eventData.eventId, interactor.getTokens())
    }
    
    func goBack() {
        router.goBack()
    }
    
    func openFilter() {
        router.openFilter(with: self)
    }
    
    func setFilterView(_ filterView: EventsFeedFilterViewController) {
        self.filterView = filterView
    }
    
    func setupFilters() {
        let filterData = interactor.getEventsFilterData()
        
        filterView?.setOrderData(orderData)
        var order = ""
        if let orderBy = orderByMap.first(where: { $1 == filterData.orderBy })?.key {
            order += orderBy
            if let orderType = orderTypeMap.first(where: { $1 == filterData.orderType })?.key {
                order += ", " + orderType
            }
        }
        
        filterView?.setOrder(order)
        filterView?.setDate(from: filterData.from, to: filterData.to)
        filterView?.setRating(from: filterData.ratingFrom, to: filterData.ratingTo)
        filterView?.setPrice(from: Int(filterData.priceFrom), to: Int(filterData.priceTo))
        filterView?.setCityName(filterData.cityName)
    }
    
    func saveFilters() {
        var filterData = interactor.getEventsFilterData()
        
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
        
        if let dateFrom = filterView?.getDateFrom() {
            filterData.from = dateFrom
        }
        
        if let dateTo = filterView?.getDateTo() {
            filterData.to = dateTo
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
        
        if let cityName = filterView?.getCityName() {
            filterData.cityName = cityName
        }
        
        interactor.setEventsFilterData(filterData)
        interactor.setNeedReload(true)
    }
}
