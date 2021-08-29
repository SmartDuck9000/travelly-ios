//
//  RestaurantsFeedViewController.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import UIKit

fileprivate struct LayoutConstants {
    static let topSpace: CGFloat = 10
    static let bottomSpace: CGFloat = 0
    static let leftSpace: CGFloat = 0
    static let rigthSpace: CGFloat = 0
    
    static let searchBarPlaceholder = "Поиск"
    static let cellHeight: CGFloat = 110
}

class RestaurantsFeedViewController: UIViewController {
    
    private var presenter: RestaurantsFeedPresenterProtocol?
    
    private let searchBar = UISearchBar()
    private let restaurantsTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.loadFeed()
    }
    
    func set(presenter: RestaurantsFeedPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getSearchRestaurantsName() -> String? {
        return searchBar.text
    }
    
    func reloadFeed() {
        DispatchQueue.main.async {
            self.restaurantsTableView.reloadData()
        }
    }
    
    @objc
    private func goBack() {
        presenter?.goBack()
    }
    
    @objc
    private func openFilter() {
        presenter?.openFilter()
    }
    
    private func setupView() {
        self.view.backgroundColor = AppColorAppearance.backgroundColor
        setupNavigationBar()
        setupRestaurantsTableView()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = NavigationBarAppearance.backgroundColor
        self.navigationController?.navigationBar.isTranslucent = false
        
        let backArrowImage = UIImage(named: "BackArrow")
        let backButton = UIButton()
        backButton.setImage(backArrowImage, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        let filterImage = UIImage(named: "Filter")
        let filterButton = UIButton()
        filterButton.setImage(filterImage, for: .normal)
        filterButton.addTarget(self, action: #selector(openFilter), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
        
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.placeholder = LayoutConstants.searchBarPlaceholder
        searchBar.tintColor = .white
        searchBar.barTintColor = .white
        searchBar.searchTextField.textColor = .white
        
        self.navigationItem.titleView = searchBar
    }
    
    private func setupRestaurantsTableView() {
        self.view.addSubview(restaurantsTableView)
        
        restaurantsTableView.delegate = self
        restaurantsTableView.dataSource = self
        restaurantsTableView.separatorColor = .clear
        restaurantsTableView.register(RestaurantsTableViewCell.self, forCellReuseIdentifier: "RestaurantsTableViewCell")
        restaurantsTableView.backgroundColor = TableViewAppearance.backgroungColor
        
        let safeArea = self.view.safeAreaLayoutGuide
        restaurantsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        restaurantsTableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: LayoutConstants.topSpace).isActive = true
        restaurantsTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: LayoutConstants.bottomSpace).isActive = true
        restaurantsTableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
        restaurantsTableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: LayoutConstants.rigthSpace).isActive = true
    }

}

extension RestaurantsFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        restaurantsTableView.deselectRow(at: indexPath, animated: true)
        presenter?.selectRestaurant(at: indexPath.row)
    }
}

extension RestaurantsFeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LayoutConstants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.restaurantsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if presenter?.restaurantsCount() == 0 {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantsTableViewCell", for: indexPath)
        
        if let restaurantsCell = cell as? RestaurantsTableViewCell, let presenter = self.presenter {
            presenter.configureRestaurantsCell(restaurantsCell, at: indexPath.row)
        }
        
        return cell
    }
}

extension RestaurantsFeedViewController: UISearchBarDelegate, UISearchDisplayDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.reloadFeed()
    }
}
