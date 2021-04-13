//
//  ProfileViewController.swift
//  Travelly
//
//  Created by Георгий Куликов on 22.03.2021.
//

import UIKit

fileprivate struct LayoutConstants {
    static let topSpace: CGFloat = 15
    static let bottomSpace: CGFloat = -15
    static let leftSpace: CGFloat = 10
    static let rightSpace: CGFloat = -10
    static let containerViewHeight: CGFloat = 150
    
    static let profileImageTopSpace: CGFloat = 15
    static let profileImageBottomSpace: CGFloat = -15
    
    static let profileTopSpace: CGFloat = 0
    static let profileBottomSpace: CGFloat = 0
    static let profileLeftSpace: CGFloat = 0
    static let profileRightSpace: CGFloat = 0
    
    static let optionCellHeight: CGFloat = 60
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
    
    func getProfileImageSize() -> CGFloat {
        return LayoutConstants.containerViewHeight - LayoutConstants.profileImageTopSpace * 2
    }
    
    private func setupView() {
        self.view.backgroundColor = HeaderAppearance.backgroundColor
        setupProfileViewContainer()
        setupOptionsTable()
    }
    
    private func setupProfileViewContainer() {
        self.view.addSubview(profileViewContainer)
        profileViewContainer.backgroundColor = HeaderAppearance.backgroundColor
        
        let safeArea = view.safeAreaLayoutGuide
        profileViewContainer.translatesAutoresizingMaskIntoConstraints = false
        profileViewContainer.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: LayoutConstants.profileTopSpace).isActive = true
        profileViewContainer.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: LayoutConstants.profileLeftSpace).isActive = true
        profileViewContainer.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: LayoutConstants.profileRightSpace).isActive = true
        profileViewContainer.heightAnchor.constraint(equalToConstant: LayoutConstants.containerViewHeight).isActive = true
        
        setupProfileImageView()
        setupNameLabel()
    }
    
    private func setupProfileImageView() {
        profileViewContainer.addSubview(profileImageView)
        profileImageView.backgroundColor = HeaderAppearance.backgroundColor
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.topAnchor.constraint(equalTo: profileViewContainer.topAnchor,
                                              constant: LayoutConstants.profileImageTopSpace).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: profileViewContainer.bottomAnchor,
                                                 constant: LayoutConstants.profileImageBottomSpace).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: profileViewContainer.leftAnchor,
                                               constant: LayoutConstants.leftSpace).isActive = true
        profileImageView.widthAnchor.constraint(
            equalToConstant: LayoutConstants.containerViewHeight - LayoutConstants.profileImageTopSpace * 2
        ).isActive = true
    }
    
    private func setupNameLabel() {
        profileViewContainer.addSubview(nameLabel)
        
        nameLabel.backgroundColor = HeaderAppearance.backgroundColor
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
        optionsTabel.dataSource = self
        optionsTabel.register(ProfileOptionTableViewCell.self, forCellReuseIdentifier: "ProfileOptionTableViewCell")
        optionsTabel.backgroundColor = TableViewAppearance.backgroungColor
        optionsTabel.tableFooterView = UIView(frame: CGRect.zero)
        
        let safeArea = view.safeAreaLayoutGuide
        optionsTabel.translatesAutoresizingMaskIntoConstraints = false
        
        optionsTabel.topAnchor.constraint(equalTo: profileViewContainer.bottomAnchor).isActive = true
        optionsTabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileOptionTableViewCell") ?? ProfileOptionTableViewCell(style: .default, reuseIdentifier: "ProfileOptionTableViewCell")
        if let optionCell = cell as? ProfileOptionTableViewCell, let presenter = self.presenter {
            presenter.configureOptionCell(optionCell, at: indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LayoutConstants.optionCellHeight
    }
}
