//
//  ToursViewController.swift
//  Travelly
//
//  Created by Георгий Куликов on 28.08.2021.
//

import UIKit

fileprivate struct LayoutConstants {
    
}

class ToursViewController: UIViewController {
    
    var presenter: ToursPresenterProtocol?
    
    private var toursTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.loadTours()
    }
    
    func reloadData() {
        toursTableView.reloadData()
    }
    
    func showError() {
        
    }
    
    @objc
    func addTourDidTap() {
        let createTourViewController = CreateTourViewController()
        createTourViewController.presenter = presenter
        presenter?.createTourView = createTourViewController
        present(createTourViewController, animated: true, completion: nil)
    }
    
    @objc
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupView() {
        setupToursTableView()
        setupNavigationBar()
    }
    
    private func setupToursTableView() {
        self.view.addSubview(toursTableView)
        
        toursTableView.delegate = self
        toursTableView.dataSource = self
        toursTableView.separatorColor = .clear
        toursTableView.register(TourTableViewCell.self, forCellReuseIdentifier: "TourTableViewCell")
        toursTableView.backgroundColor = TableViewAppearance.backgroungColor
        
        let safeArea = self.view.safeAreaLayoutGuide
        toursTableView.translatesAutoresizingMaskIntoConstraints = false
        
        toursTableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true
        toursTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        toursTableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0).isActive = true
        toursTableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0).isActive = true
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = NavigationBarAppearance.backgroundColor
        self.navigationController?.navigationBar.isTranslucent = false
        
        let backArrowImage = UIImage(named: "BackArrow")
        let backButton = UIButton()
        backButton.setImage(backArrowImage, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        let addImage = UIImage(named: "add")
        let addButton = UIButton()
        addButton.setImage(addImage, for: .normal)
        addButton.addTarget(self, action: #selector(addTourDidTap), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
    }
}

extension ToursViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toursTableView.deselectRow(at: indexPath, animated: true)
        presenter?.openTour(at: indexPath.row)
    }
}

extension ToursViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.toursCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if presenter?.toursCount() == 0 {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TourTableViewCell", for: indexPath)
        
        if let tourCell = cell as? TourTableViewCell, let presenter = self.presenter {
            presenter.configure(tourCell: tourCell, at: indexPath.row)
        }
        
        return cell
    }
}
