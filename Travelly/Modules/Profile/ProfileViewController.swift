//
//  ProfileViewController.swift
//  Travelly
//
//  Created by Георгий Куликов on 22.03.2021.
//

import UIKit

fileprivate struct LayoutConstants {
    static let topSpace: CGFloat = 0
    static let bottomSpace: CGFloat = 0
    static let leftSpace: CGFloat = 10
    static let rightSpace: CGFloat = -10
    
    static let profileTopSpace: CGFloat = 0
    static let profileBottomSpace: CGFloat = 0
    static let profileLeftSpace: CGFloat = 0
    static let profileRightSpace: CGFloat = 0
}

class ProfileViewController: UIViewController {
    
    private var presenter: ProfilePresenterProtocol?
    
    private let profileViewContainer = UIView()
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    
    private let optionsTabel = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.loadProfile()
    }
    
    func setPresenter(_ presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
    }
    
    func set(name: String) {
        DispatchQueue.main.async {
            self.nameLabel.text = name
        }
    }
    
    func getProfileImageView() -> UIImageView {
        return profileImageView
    }
    
    private func setupView() {
        setupProfileContainerView()
        setupOptionsTable()
    }
    
    private func setupProfileContainerView() {
        setupProfileImageView()
        setupNameLabel()
        self.view.addSubview(profileViewContainer)
        profileViewContainer.backgroundColor = AppColorAppearance.appColor
        
        let safeArea = view.safeAreaLayoutGuide
        profileViewContainer.translatesAutoresizingMaskIntoConstraints = false
        profileViewContainer.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: LayoutConstants.profileTopSpace).isActive = true
        profileViewContainer.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: LayoutConstants.profileLeftSpace).isActive = true
        profileViewContainer.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: LayoutConstants.profileRightSpace).isActive = true
    }
    
    private func setupProfileImageView() {
        profileViewContainer.addSubview(profileImageView)
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.centerYAnchor.constraint(equalTo: profileViewContainer.centerYAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: profileViewContainer.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
    }
    
    private func setupNameLabel() {
        profileViewContainer.addSubview(nameLabel)
        
        nameLabel.textColor = TableViewCellAppearance.textColor
        nameLabel.font = TableViewCellAppearance.font
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = .max
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: profileViewContainer.topAnchor, constant: LayoutConstants.topSpace).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: profileViewContainer.bottomAnchor, constant: LayoutConstants.bottomSpace).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: LayoutConstants.leftSpace).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: profileViewContainer.rightAnchor, constant: LayoutConstants.rightSpace).isActive = true
    }
    
    private func setupOptionsTable() {
        
    }
}
