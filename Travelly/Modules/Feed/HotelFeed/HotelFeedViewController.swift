//
//  HotelFeedViewController.swift
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

class HotelFeedViewController: UIViewController {
    
    private var presenter: HotelFeedPresenterProtocol?
    
    private let searchBar = UISearchBar()
    private let hotelTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.loadFeed()
    }
    
    func set(presenter: HotelFeedPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getSearchHotelName() -> String? {
        return searchBar.text
    }
    
    func reloadFeed() {
        DispatchQueue.main.async {
            self.hotelTableView.reloadData()
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
        setupHotelTableView()
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
    
    private func setupHotelTableView() {
        self.view.addSubview(hotelTableView)
        
        hotelTableView.delegate = self
        hotelTableView.dataSource = self
        hotelTableView.separatorColor = .clear
        hotelTableView.register(HotelTableViewCell.self, forCellReuseIdentifier: "HotelTableViewCell")
        hotelTableView.backgroundColor = TableViewAppearance.backgroungColor
        
        let safeArea = self.view.safeAreaLayoutGuide
        hotelTableView.translatesAutoresizingMaskIntoConstraints = false
        
        hotelTableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: LayoutConstants.topSpace).isActive = true
        hotelTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: LayoutConstants.bottomSpace).isActive = true
        hotelTableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
        hotelTableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: LayoutConstants.rigthSpace).isActive = true
    }

}

extension HotelFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        hotelTableView.deselectRow(at: indexPath, animated: true)
        presenter?.selectHotel(at: indexPath.row)
    }
}

extension HotelFeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LayoutConstants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.hotelsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if presenter?.hotelsCount() == 0 {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotelTableViewCell", for: indexPath)
        
        if let hotelCell = cell as? HotelTableViewCell, let presenter = self.presenter {
            presenter.configureHotelCell(hotelCell, at: indexPath.row)
        }
        
        return cell
    }
}

extension HotelFeedViewController: UISearchBarDelegate, UISearchDisplayDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.reloadFeed()
    }
}
