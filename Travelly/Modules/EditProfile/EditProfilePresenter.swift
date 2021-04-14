//
//  EditProfilePresenter.swift
//  Travelly
//
//  Created by Георгий Куликов on 03.04.2021.
//

import UIKit

class EditProfilePresenter: EditProfilePresenterProtocol {
    
    private weak var view: EditProfileViewController!
    private var router: EditProfileRouterProtocol
    private var interactor: EditProfileInteractorProtocol
    
    init(view: EditProfileViewController, router: EditProfileRouterProtocol, interactor: EditProfileInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func setupProfileData() {
        let firstName = interactor.getFirstName()
        let lastName = interactor.getLastName()
        
        view.setFirstName(firstName)
        view.setLastName(lastName)
        
        let imageView = view.getPhotoImageView()
        let cornerRadius = view.getPhotoImageViewSize() / 2
        interactor.loadImage(to: imageView, with: cornerRadius, "ImagePlaceholder")
    }
    
    func saveChanges() {
        guard let firstName = view.getFirstName(), firstName != "" else {
            router.showError(message: "Введите имя")
            return
        }
        
        guard let lastName = view.getLastName(), lastName != "" else {
            router.showError(message: "Введите фамилию")
            return
        }
        
        guard let email = view.getEmail(), email != "" else {
            router.showError(message: "Введите почту")
            return
        }
        
        guard let oldPassword = view.getOldPassword(), oldPassword != "" else {
            router.showError(message: "Введите пароль")
            return
        }
        
        let newPassword = view.getNewPassword() ?? ""
        
        var photoUrl = ""
        if view.isImageChanged(), let newImage = view.getPhotoImageView().image {
            photoUrl = interactor.getUrl(for: newImage)
        }
        
        let newProfileData = EditProfileData(id: interactor.getUserId(),
                                             email: email,
                                             oldPassword: oldPassword,
                                             newPassword: newPassword,
                                             firstName: firstName,
                                             lastName: lastName,
                                             photoUrl: photoUrl)
        
        interactor.updateProfileData(newProfileData)
    }
}
