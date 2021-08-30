//
//  CityToursPresenter.swift
//  Travelly
//
//  Created by Георгий Куликов on 28.08.2021.
//

import UIKit

protocol CityToursPresenterProtocol {
    var view: CityToursViewController? { get set }
    var createCityTourView: CreateCityTourViewController? { get set }
    
    func loadCityTours()
    func addCityTour(with cityTourData: PostedCityTourModel)
    func deleteCityTour(at index: Int)
    func openCityTour(at index: Int)
    func cityTourData(for index: Int) -> CityTourModel?
    func cityToursCount() -> Int
    func configure(cityTourCell: CityTourTableViewCell, at index: Int)
    
    func loadCities(completion: @escaping ([CityData]) -> ())
}

class CityToursPresenter: CityToursPresenterProtocol {
    weak var view: CityToursViewController?
    weak var createCityTourView: CreateCityTourViewController?
    
    private var networkService: NetworkProtocol
    private var dataStorage: DataStorageProtocol
    
    private var tokens: SecurityTokens
    private var tour_id: Int
    
    private var data: [CityTourModel] = []
    
    init(
        view: CityToursViewController,
        networkService: NetworkProtocol,
        dataStorage: DataStorageProtocol,
        tokens: SecurityTokens,
        tour_id: Int
    ) {
        self.view = view
        self.networkService = networkService
        self.dataStorage = dataStorage
        self.tokens = tokens
        self.tour_id = tour_id
    }
    
    func loadCityTours() {
        networkService.get(
            query: "0.0.0.0:5001/api/users/tours/city_tours",
            tokens: tokens,
            parameters: TourIdData(tour_id: tour_id),
            type: .http
        ) { (data, error, statusCode) in
            if statusCode == 401 {
                self.networkService.refreshToken(query: "0.0.0.0:5002/api/auth", tokens: self.tokens, type: .http) { (data, error, statusCode) in
                    guard let data = data else {
                        self.dataStorage.deleteAuthData()
                        self.handleCityToursLoaded(nil, error, true)
                        return
                    }
                    guard let authData = try? JSONDecoder().decode(AuthData.self, from: data) else {
                        self.dataStorage.deleteAuthData()
                        self.handleCityToursLoaded(nil, error, true)
                        return
                    }
                    self.tokens = SecurityTokens(accessToken: authData.accessToken, refreshToken: authData.refreshToken)
                    self.dataStorage.update(authData: authData)
                    self.loadCityTours()
                }
            } else {
                if error != nil {
                    self.handleCityToursLoaded(nil, error, false)
                    return
                }
                
                guard let data = data else {
                    self.handleCityToursLoaded(nil, error, false)
                    return
                }
                
                guard let cityToursData = try? JSONDecoder().decode([CityTourModel].self, from: data) else {
                    if let strData = String(data: data, encoding: .utf8) {
                        print(strData)
                    }
                    self.handleCityToursLoaded(nil, error, false)
                    return
                }
                
                self.handleCityToursLoaded(cityToursData, nil, false)
            }
        }
    }
    
    func addCityTour(with cityTourData: PostedCityTourModel) {
        var data = cityTourData
        data.tour_id = tour_id
        
        networkService.post(
            query: "0.0.0.0:5001/api/users/city_tours",
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
                self.loadCityTours()
            }
        }
    }
    
    func deleteCityTour(at index: Int) {
        let tour = data.remove(at: index)
        
        networkService.delete(
            query: "0.0.0.0:5001/api/users/tours",
            tokens: tokens,
            data: CityTourIdData(city_tour_id: tour.city_tour_id),
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
    
    func openCityTour(at index: Int) {
        let assembly: CityTourInfoAssemblyProtocol = CityTourInfoAssembly()
        let vc = assembly.createModule(
            cityTourData: data[index],
            postedCityTourData: PostedCityTourModel(from: data[index], tourId: tour_id),
            tokens: tokens
        )
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func cityTourData(for index: Int) -> CityTourModel? {
        if index >= data.count {
            return nil
        }
        return data[index]
    }
    
    func cityToursCount() -> Int {
        data.count
    }
    
    func configure(cityTourCell: CityTourTableViewCell, at index: Int) {
        if index < data.count && index >= 0 {
            cityTourCell.setupCell()
            cityTourCell.configure(with: data[index])
        }
    }
    
    func loadCities(completion: @escaping ([CityData]) -> ()) {
        networkService.get(
            query: "0.0.0.0:5005/api/info/cities",
            tokens: tokens,
            type: .http
        ) { (data, error, statusCode) in
            if statusCode == 401 {
                self.networkService.refreshToken(query: "0.0.0.0:5002/api/auth", tokens: self.tokens, type: .http) { (data, error, statusCode) in
                    guard let data = data else {
                        self.dataStorage.deleteAuthData()
                        self.createCityTourView?.dismiss(animated: true, completion: {
                            let assembly: AuthAssemblyProtocol = AuthAssembly()
                            let authView: AuthViewController = assembly.createModule()
                            authView.modalPresentationStyle = .fullScreen
                            DispatchQueue.main.async {
                                self.view?.present(authView, animated: false, completion: nil)
                            }
                        })
                        return
                    }
                    guard let authData = try? JSONDecoder().decode(AuthData.self, from: data) else {
                        self.dataStorage.deleteAuthData()
                        self.createCityTourView?.dismiss(animated: true, completion: {
                            let assembly: AuthAssemblyProtocol = AuthAssembly()
                            let authView: AuthViewController = assembly.createModule()
                            authView.modalPresentationStyle = .fullScreen
                            DispatchQueue.main.async {
                                self.view?.present(authView, animated: false, completion: nil)
                            }
                        })
                        return
                    }
                    self.tokens = SecurityTokens(accessToken: authData.accessToken, refreshToken: authData.refreshToken)
                    self.dataStorage.update(authData: authData)
                    self.loadCityTours()
                }
            } else {
                if error != nil {
                    self.createCityTourView?.dismiss(animated: true, completion: nil)
                    return
                }
                
                guard let data = data else {
                    self.createCityTourView?.dismiss(animated: true, completion: nil)
                    return
                }
                
                guard let cityData = try? JSONDecoder().decode([CityData].self, from: data) else {
                    if let strData = String(data: data, encoding: .utf8) {
                        print(strData)
                    }
                    self.createCityTourView?.dismiss(animated: true, completion: nil)
                    return
                }
                
                DispatchQueue.main.async {
                    completion(cityData)
                }
            }
        }
    }
    
    private func handleCityToursLoaded(
        _ data: [CityTourModel]?,
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
