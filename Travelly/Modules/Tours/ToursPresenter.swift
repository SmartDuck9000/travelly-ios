//
//  ToursPresenter.swift
//  Travelly
//
//  Created by Георгий Куликов on 28.08.2021.
//

import UIKit

protocol ToursPresenterProtocol {
    var view: ToursViewController? { get set }
    var createTourView: CreateTourViewController? { get set }
    
    func loadTours()
    func addTour(with tourData: PostedTourModel)
    func deleteTour(at index: Int)
    func openTour(at index: Int)
    func tourData(for index: Int) -> ToursModel?
    func toursCount() -> Int
    func configure(tourCell: TourTableViewCell, at index: Int)
}

class ToursPresenter: ToursPresenterProtocol {
    
    weak var view: ToursViewController?
    weak var createTourView: CreateTourViewController?
    
    private var networkService: NetworkProtocol
    private var dataStorage: DataStorageProtocol
    
    private var tokens: SecurityTokens
    private var userId: Int
    
    private var data: [ToursModel] = []
    
    init(
        view: ToursViewController,
        networkService: NetworkProtocol,
        dataStorage: DataStorageProtocol,
        tokens: SecurityTokens,
        userId: Int
    ) {
        self.view = view
        self.networkService = networkService
        self.dataStorage = dataStorage
        self.tokens = tokens
        self.userId = userId
    }
    
    
    func loadTours() {
        networkService.get(
            query: "0.0.0.0:5001/api/users/tours",
            tokens: tokens,
            parameters: UserIdData(userId: userId),
            type: .http
        ) { (data, error, statusCode) in
            if statusCode == 401 {
                self.networkService.refreshToken(query: "0.0.0.0:5002/api/auth", tokens: self.tokens, type: .http) { (data, error, statusCode) in
                    guard let data = data else {
                        self.dataStorage.deleteAuthData()
                        self.handleToursLoaded(nil, error, true)
                        return
                    }
                    guard let authData = try? JSONDecoder().decode(AuthData.self, from: data) else {
                        self.dataStorage.deleteAuthData()
                        self.handleToursLoaded(nil, error, true)
                        return
                    }
                    self.tokens = SecurityTokens(accessToken: authData.accessToken, refreshToken: authData.refreshToken)
                    self.dataStorage.update(authData: authData)
                    self.loadTours()
                }
            } else {
                if error != nil {
                    self.handleToursLoaded(nil, error, false)
                    return
                }
                
                guard let data = data else {
                    self.handleToursLoaded(nil, error, false)
                    return
                }
                
                guard let toursData = try? JSONDecoder().decode([ToursModel].self, from: data) else {
                    if let strData = String(data: data, encoding: .utf8) {
                        print(strData)
                    }
                    self.handleToursLoaded(nil, error, false)
                    return
                }
                
                self.handleToursLoaded(toursData, nil, false)
            }
        }
    }
    
    func addTour(with tourData: PostedTourModel) {
        var data = tourData
        data.user_id = userId
        
        networkService.post(
            query: "0.0.0.0:5001/api/users/tours",
            tokens: tokens,
            data: data,
            type: .http
        ) { (_, error, statusCode) in
            if statusCode == 401 {
                self.networkService.refreshToken(query: "0.0.0.0:5002/api/auth", tokens: self.tokens, type: .http) { (data, error, statusCode) in
                    guard let data = data else {
                        self.dataStorage.deleteAuthData()
                        let assembly: AuthAssemblyProtocol = AuthAssembly()
                        let authView: AuthViewController = assembly.createModule()
                        authView.modalPresentationStyle = .fullScreen
                        DispatchQueue.main.async {
                            self.view?.present(authView, animated: false, completion: nil)
                        }
                        return
                    }
                    guard let authData = try? JSONDecoder().decode(AuthData.self, from: data) else {
                        self.dataStorage.deleteAuthData()
                        let assembly: AuthAssemblyProtocol = AuthAssembly()
                        let authView: AuthViewController = assembly.createModule()
                        authView.modalPresentationStyle = .fullScreen
                        DispatchQueue.main.async {
                            self.view?.present(authView, animated: false, completion: nil)
                        }
                        return
                    }
                    self.tokens = SecurityTokens(accessToken: authData.accessToken, refreshToken: authData.refreshToken)
                    self.dataStorage.update(authData: authData)
                }
            } else if statusCode == 200 {
                self.loadTours()
            }
        }
    }
    
    func deleteTour(at index: Int) {
        let tour = data.remove(at: index)
        
        networkService.delete(
            query: "0.0.0.0:5001/api/users/tours",
            tokens: tokens,
            data: TourIdData(tour_id: tour.tour_id),
            type: .http
        ) { (_, _, statusCode) in
            if statusCode == 401 {
                self.networkService.refreshToken(query: "0.0.0.0:5002/api/auth", tokens: self.tokens, type: .http) { (data, error, statusCode) in
                    guard let data = data else {
                        self.dataStorage.deleteAuthData()
                        let assembly: AuthAssemblyProtocol = AuthAssembly()
                        let authView: AuthViewController = assembly.createModule()
                        authView.modalPresentationStyle = .fullScreen
                        DispatchQueue.main.async {
                            self.view?.present(authView, animated: false, completion: nil)
                        }
                        return
                    }
                    guard let authData = try? JSONDecoder().decode(AuthData.self, from: data) else {
                        self.dataStorage.deleteAuthData()
                        let assembly: AuthAssemblyProtocol = AuthAssembly()
                        let authView: AuthViewController = assembly.createModule()
                        authView.modalPresentationStyle = .fullScreen
                        DispatchQueue.main.async {
                            self.view?.present(authView, animated: false, completion: nil)
                        }
                        return
                    }
                    self.tokens = SecurityTokens(accessToken: authData.accessToken, refreshToken: authData.refreshToken)
                    self.dataStorage.update(authData: authData)
                }
            }
        }
    }
    
    func openTour(at index: Int) {
        let cityToursAssembly: CityToursAssemblyProtocol = CityToursAssembly()
        let cityToursView = cityToursAssembly.createModule(tourId: data[index].tour_id, tokens: tokens)
        view?.navigationController?.pushViewController(cityToursView, animated: true)
    }
    
    func tourData(for index: Int) -> ToursModel? {
        if index >= data.count {
            return nil
        }
        return data[index]
    }
    
    func toursCount() -> Int {
        data.count
    }
    
    func configure(tourCell: TourTableViewCell, at index: Int) {
        if index < data.count && index >= 0 {
            tourCell.setupCell()
            tourCell.configure(with: data[index])
        }
    }
    
    private func handleToursLoaded(
        _ data: [ToursModel]?,
        _ error: Error?,
        _ needAuth: Bool
    ) {
        if needAuth {
            let assembly: AuthAssemblyProtocol = AuthAssembly()
            let authView: AuthViewController = assembly.createModule()
            authView.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.view?.present(authView, animated: false, completion: nil)
            }
            return
        }
        
        if let err = error {
            print(err.localizedDescription)
            
            DispatchQueue.main.async {
                self.view?.showError()
            }
        }
        
        if let data = data {
            self.data = data
        }
        
        DispatchQueue.main.async {
            self.view?.reloadData()
        }
    }
}
