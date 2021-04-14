//
//  EditProfileRouter.swift
//  Travelly
//
//  Created by Георгий Куликов on 03.04.2021.
//

import UIKit

class EditProfileRouter: EditProfileRouterProtocol {
    
    private var view: EditProfileViewController
    
    init(view: EditProfileViewController) {
        self.view = view
    }
    
    func closeEditProfileOption() {
        self.view.navigationController?.popViewController(animated: true)
    }
    
    func showError(message: String) {
        
    }
}
