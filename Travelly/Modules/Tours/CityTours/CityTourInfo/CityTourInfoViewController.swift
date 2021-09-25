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
    static let profileImageLeftSpace: CGFloat = 20
    static let profileImageBottomSpace: CGFloat = -15
    static let nameLabelHeight: CGFloat = 30
    
    static let profileTopSpace: CGFloat = 0
    static let profileBottomSpace: CGFloat = 0
    static let profileLeftSpace: CGFloat = 0
    static let profileRightSpace: CGFloat = 0
    
    static let optionCellHeight: CGFloat = 60
}

class CityTourInfoViewController: UIViewController {
    
    var presenter: CityTourInfoPresenterProtocol?
    
    private var containerView = UIView()
    
    private var countryCityLabel = UILabel()
    private var priceLabel = UILabel()
    private var dateFromLabel = UILabel()
    private var dateToLabel = UILabel()
    
    private let optionsTabel = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let model = presenter?.cityTourData else { return }
        setupView()
        configure(with: model)
    }
    
    @objc
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func configure(with model: CityTourModel) {
        countryCityLabel.text = "\(model.country_name), \(model.city_name)"
        priceLabel.text = "Цена: \(model.city_tour_price)"
        dateFromLabel.text = "Начало: \(model.date_from)"
        dateToLabel.text = "Конец: \(model.date_to)"
    }
    
    func setupView() {
        self.view.addSubview(containerView)
        containerView.backgroundColor = HeaderAppearance.backgroundColor
        
        let safeArea = view.safeAreaLayoutGuide
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: LayoutConstants.profileTopSpace).isActive = true
        containerView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: LayoutConstants.profileLeftSpace).isActive = true
        containerView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: LayoutConstants.profileRightSpace).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: LayoutConstants.containerViewHeight).isActive = true
        
        setupCountryCityLabel()
        setupPriceLabel()
        setupDateFromLabel()
        setupDateToLabel()
        setupNavigationBar()
        setupOptionsTable()
    }
    
    
    func setupCountryCityLabel() {
        containerView.addSubview(countryCityLabel)
        countryCityLabel.translatesAutoresizingMaskIntoConstraints = false
        countryCityLabel.textColor = .white
        countryCityLabel.font = FeedCellAppearance.boldFont
        
        countryCityLabel.topAnchor.constraint(
            equalTo: containerView.topAnchor,
            constant: 15
        ).isActive = true
        
        countryCityLabel.leftAnchor.constraint(
            equalTo: containerView.leftAnchor,
            constant: 15
        ).isActive = true
        
        countryCityLabel.rightAnchor.constraint(
            equalTo: containerView.rightAnchor,
            constant: -10
        ).isActive = true
    }
    
    func setupPriceLabel() {
        containerView.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textColor = .white
        
        priceLabel.topAnchor.constraint(
            equalTo: countryCityLabel.bottomAnchor,
            constant: 10
        ).isActive = true
        
        priceLabel.leftAnchor.constraint(
            equalTo: containerView.leftAnchor,
            constant: 15
        ).isActive = true
        
        priceLabel.rightAnchor.constraint(
            equalTo: containerView.rightAnchor,
            constant: -10
        ).isActive = true
    }
    
    func setupDateFromLabel() {
        containerView.addSubview(dateFromLabel)
        dateFromLabel.translatesAutoresizingMaskIntoConstraints = false
        dateFromLabel.textColor = .white
        
        dateFromLabel.topAnchor.constraint(
            equalTo: priceLabel.bottomAnchor,
            constant: 10
        ).isActive = true
        
        dateFromLabel.leftAnchor.constraint(
            equalTo: containerView.leftAnchor,
            constant: 15
        ).isActive = true
        
        dateFromLabel.rightAnchor.constraint(
            equalTo: containerView.rightAnchor,
            constant: -10
        ).isActive = true
    }
    
    func setupDateToLabel() {
        containerView.addSubview(dateToLabel)
        dateToLabel.translatesAutoresizingMaskIntoConstraints = false
        dateToLabel.textColor = .white
        
        dateToLabel.topAnchor.constraint(
            equalTo: dateFromLabel.bottomAnchor,
            constant: 10
        ).isActive = true
        
        dateToLabel.leftAnchor.constraint(
            equalTo: containerView.leftAnchor,
            constant: 15
        ).isActive = true
        
        dateToLabel.rightAnchor.constraint(
            equalTo: containerView.rightAnchor,
            constant: -10
        ).isActive = true
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = NavigationBarAppearance.backgroundColor
        self.navigationController?.navigationBar.isTranslucent = false
        
        let backArrowImage = UIImage(named: "BackArrow")
        let backButton = UIButton()
        backButton.setImage(backArrowImage, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func setupOptionsTable() {
        self.view.addSubview(optionsTabel)
        
        optionsTabel.delegate = self
        optionsTabel.dataSource = self
        optionsTabel.register(
            CityTourInfoOptionTableViewCell.self,
            forCellReuseIdentifier: "CityTourInfoOptionTableViewCell"
        )
        optionsTabel.backgroundColor = TableViewAppearance.backgroungColor
        optionsTabel.tableFooterView = UIView(frame: CGRect.zero)
        
        let safeArea = view.safeAreaLayoutGuide
        optionsTabel.translatesAutoresizingMaskIntoConstraints = false
        
        optionsTabel.topAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        optionsTabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        optionsTabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        optionsTabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
    }
}

extension CityTourInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        optionsTabel.deselectRow(at: indexPath, animated: true)
        presenter?.selectOption(at: indexPath.row)
    }
}

extension CityTourInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.optionsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "CityTourInfoOptionTableViewCell"
        ) ?? CityTourInfoOptionTableViewCell(
            style: .default,
            reuseIdentifier: "CityTourInfoOptionTableViewCell"
        )
        if let optionCell = cell as? CityTourInfoOptionTableViewCell, let presenter = self.presenter {
            presenter.configureOptionCell(optionCell, at: indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LayoutConstants.optionCellHeight
    }
}
