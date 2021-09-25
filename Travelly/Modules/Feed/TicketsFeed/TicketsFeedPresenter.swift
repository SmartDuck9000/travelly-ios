//
//  TicketsFeedPresenter.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import UIKit

class TicketsFeedPresenter: TicketsFeedPresenterProtocol, TicketsFilterPresenterProtocol {

    private weak var view: TicketsFeedViewController?
    private weak var filterView: TicketsFeedFilterViewController?
    private let router: TicketsFeedRouterProtocol
    private let interactor: TicketsFeedInteractorProtocol
    
    private let orderByMap: [String:String] = [
        "По цене": "price"
    ]
    private let orderTypeMap: [String:String] = [
        "по возрастанию": "inc",
        "по убыванию": "dec"
    ]
    
    private let orderData: [String] = [
        "По цене, по возрастанию",
        "По цене, по убыванию"
    ]
    
    init(view: TicketsFeedViewController, router: TicketsFeedRouterProtocol, interactor: TicketsFeedInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func loadFeed() {
        let filterData = interactor.getTicketsFilterData()
        interactor.setTicketsFilterData(filterData)
        
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
        let filterData = interactor.getTicketsFilterData()
        interactor.setTicketsFilterData(filterData)
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
    
    func ticketsCount() -> Int {
        if interactor.ticketsCount() == 0 {
            return 0
        }
        return interactor.ticketsCount() + 1
    }
    
    func configureTicketsCell(_ cell: TicketsTableViewCell, at index: Int) {
        
        if index == interactor.ticketsCount() {
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
            let ticketsData = interactor.getTicketsData(at: index)
            cell.setupCell(with: ticketsData)
        }
    }
    
    func selectTicket(at index: Int) {
        let ticketsData = interactor.getTicketsData(at: index)
        router.openFullInfo(with: ticketsData.ticketId, interactor.getTokens())
    }
    
    func goBack() {
        router.goBack()
    }
    
    func openFilter() {
        router.openFilter(with: self)
    }
    
    func setFilterView(_ filterView: TicketsFeedFilterViewController) {
        self.filterView = filterView
    }
    
    func setupFilters() {
        let filterData = interactor.getTicketsFilterData()
        
        filterView?.setOrderData(orderData)
        var order = ""
        if let orderBy = orderByMap.first(where: { $1 == filterData.orderBy })?.key {
            order += orderBy
            if let orderType = orderTypeMap.first(where: { $1 == filterData.orderType })?.key {
                order += ", " + orderType
            }
        }
        
        filterView?.setOrder(order)
        filterView?.setDate(from: filterData.dateFrom, to: filterData.dateTo)
        filterView?.setPrice(from: Int(filterData.priceFrom), to: Int(filterData.priceTo))
        filterView?.setOriginalCityName(filterData.origCityName)
        filterView?.setDestinationCityName(filterData.destCityName)
    }
    
    func saveFilters() {
        var filterData = interactor.getTicketsFilterData()
        
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
            filterData.dateFrom = dateFrom
        }
        
        if let dateTo = filterView?.getDateTo() {
            filterData.dateTo = dateTo
        }
        
        if let priceFrom = filterView?.getPriceFrom() {
            filterData.priceFrom = Double(priceFrom)
        }
        
        if let priceTo = filterView?.getPriceTo() {
            filterData.priceTo = Double(priceTo)
        }
        
        if let origCityName = filterView?.getOriginalCityName() {
            filterData.origCityName = origCityName
        }
        
        if let destCityName = filterView?.getDestinationCityName() {
            filterData.destCityName = destCityName
        }
        
        interactor.setTicketsFilterData(filterData)
        interactor.setNeedReload(true)
    }
}
