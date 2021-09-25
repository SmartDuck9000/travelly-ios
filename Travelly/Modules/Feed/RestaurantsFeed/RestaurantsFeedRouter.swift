//
//  RestaurantsFeedRouter.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import UIKit

class RestaurantsFeedRouter: RestaurantsFeedRouterProtocol {
    private weak var view: RestaurantsFeedViewController!
    
    init(view: RestaurantsFeedViewController) {
        self.view = view
    }
    
    func goBack() {
        view.navigationController?.popViewController(animated: true)
    }
    
    func openFullInfo(with id: Int, _ tokens: SecurityTokens) {
        let restaurantsInfoAssembly: RestaurantsInfoAssemblyProtocol = RestaurantInfoAssembly()
        let restaurantsInfoView = restaurantsInfoAssembly.createModule(with: id, tokens)
        view.navigationController?.pushViewController(restaurantsInfoView, animated: true)
    }
    
    func openFilter(with presenter: RestaurantsFilterPresenterProtocol) {
        let filterAssembly: RestaurantsFilterAssemblyProtocol = RestaurantsFilterAssembly()
        let filterView = filterAssembly.createModule(with: presenter)
        view.navigationController?.pushViewController(filterView, animated: true)
    }
    
    func openAuth() {
        let assembly: AuthAssemblyProtocol = AuthAssembly()
        let authView: AuthViewController = assembly.createModule()
        authView.modalPresentationStyle = .fullScreen
        view.present(authView, animated: false, completion: nil)
    }
}
