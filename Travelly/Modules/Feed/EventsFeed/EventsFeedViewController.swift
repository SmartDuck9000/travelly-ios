//
//  EventsFeedViewController.swift
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
    static let cellHeight: CGFloat = 140
}

class EventsFeedViewController: UIViewController {
    
    private var presenter: EventsFeedPresenterProtocol?
    
    private let searchBar = UISearchBar()
    private let eventsTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.loadFeed()
    }
    
    func set(presenter: EventsFeedPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getSearchEventsName() -> String? {
        return searchBar.text
    }
    
    func reloadFeed() {
        DispatchQueue.main.async {
            self.eventsTableView.reloadData()
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
        setupEventsTableView()
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
    
    private func setupEventsTableView() {
        self.view.addSubview(eventsTableView)
        
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        eventsTableView.separatorColor = .clear
        eventsTableView.register(EventsTableViewCell.self, forCellReuseIdentifier: "EventsTableViewCell")
        eventsTableView.backgroundColor = TableViewAppearance.backgroungColor
        
        let safeArea = self.view.safeAreaLayoutGuide
        eventsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        eventsTableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: LayoutConstants.topSpace).isActive = true
        eventsTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: LayoutConstants.bottomSpace).isActive = true
        eventsTableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
        eventsTableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: LayoutConstants.rigthSpace).isActive = true
    }

}

extension EventsFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventsTableView.deselectRow(at: indexPath, animated: true)
        presenter?.selectEvent(at: indexPath.row)
    }
}

extension EventsFeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LayoutConstants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.eventsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if presenter?.eventsCount() == 0 {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventsTableViewCell", for: indexPath)
        
        if let eventCell = cell as? EventsTableViewCell, let presenter = self.presenter {
            presenter.configureEventsCell(eventCell, at: indexPath.row)
        }
        
        return cell
    }
}

extension EventsFeedViewController: UISearchBarDelegate, UISearchDisplayDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.reloadFeed()
    }
}
