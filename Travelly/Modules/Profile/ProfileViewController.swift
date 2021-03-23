//
//  ProfileViewController.swift
//  Travelly
//
//  Created by Георгий Куликов on 22.03.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var presenter: ProfilePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.loadProfile()
    }
    
    private func setupView() {
        
    }
    
    func setPresenter(_ presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
    }

}
