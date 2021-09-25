//
//  TicketsFeedViewController.swift
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
    static let cellHeight: CGFloat = 160
}

class TicketsFeedViewController: UIViewController {
    
    private var presenter: TicketsFeedPresenterProtocol?
    private let ticketsTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.loadFeed()
    }
    
    func set(presenter: TicketsFeedPresenterProtocol) {
        self.presenter = presenter
    }
    
    func reloadFeed() {
        DispatchQueue.main.async {
            self.ticketsTableView.reloadData()
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
        setupTicketsTableView()
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
    }
    
    private func setupTicketsTableView() {
        self.view.addSubview(ticketsTableView)
        
        ticketsTableView.delegate = self
        ticketsTableView.dataSource = self
        ticketsTableView.separatorColor = .clear
        ticketsTableView.register(TicketsTableViewCell.self, forCellReuseIdentifier: "TicketsTableViewCell")
        ticketsTableView.backgroundColor = TableViewAppearance.backgroungColor
        
        let safeArea = self.view.safeAreaLayoutGuide
        ticketsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        ticketsTableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: LayoutConstants.topSpace).isActive = true
        ticketsTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: LayoutConstants.bottomSpace).isActive = true
        ticketsTableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
        ticketsTableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: LayoutConstants.rigthSpace).isActive = true
    }

}

extension TicketsFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ticketsTableView.deselectRow(at: indexPath, animated: true)
        presenter?.selectTicket(at: indexPath.row)
    }
}

extension TicketsFeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LayoutConstants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.ticketsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if presenter?.ticketsCount() == 0 {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketsTableViewCell", for: indexPath)
        
        if let ticketCell = cell as? TicketsTableViewCell, let presenter = self.presenter {
            presenter.configureTicketsCell(ticketCell, at: indexPath.row)
        }
        
        return cell
    }
}
