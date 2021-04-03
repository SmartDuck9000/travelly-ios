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
        setupProfileViewContainer()
        setupOptionsTable()
    }
    
    private func setupProfileViewContainer() {
        setupProfileImageView()
        setupNameLabel()
        self.view.addSubview(profileViewContainer)
        profileViewContainer.backgroundColor = HeaderAppearance.backgroungColor
        
        let safeArea = view.safeAreaLayoutGuide
        profileViewContainer.translatesAutoresizingMaskIntoConstraints = false
        profileViewContainer.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: LayoutConstants.profileTopSpace).isActive = true
        profileViewContainer.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: LayoutConstants.profileLeftSpace).isActive = true
        profileViewContainer.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: LayoutConstants.profileRightSpace).isActive = true
    }
    
    private func setupProfileImageView() {
        profileViewContainer.addSubview(profileImageView)
        profileImageView.backgroundColor = HeaderAppearance.backgroungColor
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.centerYAnchor.constraint(equalTo: profileViewContainer.centerYAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: profileViewContainer.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
    }
    
    private func setupNameLabel() {
        profileViewContainer.addSubview(nameLabel)
        
        nameLabel.backgroundColor = HeaderAppearance.backgroungColor
        nameLabel.textColor = HeaderAppearance.textColor
        nameLabel.font = HeaderAppearance.font
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = .max
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: profileViewContainer.topAnchor, constant: LayoutConstants.topSpace).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: profileViewContainer.bottomAnchor, constant: LayoutConstants.bottomSpace).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: LayoutConstants.leftSpace).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: profileViewContainer.rightAnchor, constant: LayoutConstants.rightSpace).isActive = true
    }
    
    private func setupOptionsTable() {
        self.view.addSubview(optionsTabel)
        
        optionsTabel.delegate = self
        optionsTabel.register(ProfileOptionTableViewCell.self, forCellReuseIdentifier: "ProfileOptionTableViewCell")
        optionsTabel.backgroundColor = TableViewAppearance.backgroungColor
        
        let safeArea = view.safeAreaLayoutGuide
        optionsTabel.translatesAutoresizingMaskIntoConstraints = false
        
        optionsTabel.topAnchor.constraint(equalTo: profileViewContainer.bottomAnchor).isActive = true
        optionsTabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        optionsTabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        optionsTabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectOption(at: indexPath.row)
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.optionsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = self.presenter else {
            return tableView.dequeueReusableCell(withIdentifier: "ProfileOptionTableViewCell", for: indexPath)
        }
        return presenter.getOption(from: tableView, at: indexPath.row)
    }
}
