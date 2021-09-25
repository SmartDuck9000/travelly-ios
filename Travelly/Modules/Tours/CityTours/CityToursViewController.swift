//
//  CityToursViewController.swift
//  Travelly
//
//  Created by Георгий Куликов on 28.08.2021.
//

import UIKit

class CityToursViewController: UIViewController {
    
    var presenter: CityToursPresenterProtocol?
    
    private var cityToursTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.loadCityTours()
    }
    
    func reloadData() {
        cityToursTableView.reloadData()
    }
    
    func showError() {
        
    }
    
    @objc
    func addCityTourDidTap() {
        let createCityTourViewController = CreateCityTourViewController()
        createCityTourViewController.presenter = presenter
        presenter?.createCityTourView = createCityTourViewController
        present(createCityTourViewController, animated: true, completion: nil)
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
        self.view.addSubview(cityToursTableView)
        
        cityToursTableView.delegate = self
        cityToursTableView.dataSource = self
        cityToursTableView.separatorColor = .clear
        cityToursTableView.register(CityTourTableViewCell.self, forCellReuseIdentifier: "CityTourTableViewCell")
        cityToursTableView.backgroundColor = TableViewAppearance.backgroungColor
        
        let safeArea = self.view.safeAreaLayoutGuide
        cityToursTableView.translatesAutoresizingMaskIntoConstraints = false
        
        cityToursTableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true
        cityToursTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        cityToursTableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0).isActive = true
        cityToursTableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0).isActive = true
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
        addButton.addTarget(self, action: #selector(addCityTourDidTap), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
    }
}

extension CityToursViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cityToursTableView.deselectRow(at: indexPath, animated: true)
        presenter?.openCityTour(at: indexPath.row)
    }
}

extension CityToursViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.cityToursCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if presenter?.cityToursCount() == 0 {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityTourTableViewCell", for: indexPath)
        
        if let cityTourCell = cell as? CityTourTableViewCell, let presenter = self.presenter {
            presenter.configure(cityTourCell: cityTourCell, at: indexPath.row)
        }
        
        return cell
    }
}
