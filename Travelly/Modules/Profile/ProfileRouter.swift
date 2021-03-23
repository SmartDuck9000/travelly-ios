//
//  ProfileRouter.swift
//  Travelly
//
//  Created by Георгий Куликов on 22.03.2021.
//

import UIKit

class ProfileRouter: ProfileRouterProtocol {
    private var view: ProfileViewController
    
    init(view: ProfileViewController) {
        self.view = view
    }
}
