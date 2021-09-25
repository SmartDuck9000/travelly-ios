//
//  TicketsFeedFilterViewController.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import UIKit
import DropDown

fileprivate struct LayoutConstants {
    static let topSpace: CGFloat = 15
    static let bottomSpace: CGFloat = -15
    static let leftSpace: CGFloat = 15
    static let rightSpace: CGFloat = -15
    
    static let betweenLeftSpace: CGFloat = 15
    
    static let orderLabelText = "Сортировать"
    
    static let dateLabelText = "Дата отправления"
    static let dateFromPlaceholder = "С"
    static let dateToPlaceholder = "До"
    static let dateWidth: CGFloat = 60
    static let dateHeight: CGFloat = 25
    
    static let priceLabelText = "Цена"
    static let priceFromPlaceholder = "От"
    static let priceToPlaceholder = "До"
    static let priceWidth: CGFloat = 80
    static let priceHeight: CGFloat = 25
    
    static let origCityNamePlaceholder = "Город отправления"
    static let origCityNameHeight: CGFloat = 30
    
    static let destCityNamePlaceholder = "Город назначения"
    static let destCityNameHeight: CGFloat = 30
}

class TicketsFeedFilterViewController: UIViewController {
    
    private var presenter: TicketsFilterPresenterProtocol?
    
    private let orderLabel = UILabel()
    private let orderButton = UIButton()
    private let orderMenu = DropDown()
    
    private let dateFromLabel = UILabel()
    private let dateFrom = UIDatePicker()
    private let dateToLabel = UILabel()
    private let dateTo = UIDatePicker()
    
    private let priceLabel = UILabel()
    private let priceFrom = UITextField()
    private let priceTo = UITextField()
    
    private let origCityName = UITextField()
    private let destCityName = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func set(_ presenter: TicketsFilterPresenterProtocol) {
        self.presenter = presenter
    }
    
    func setOrderData(_ dataSource: [String]) {
        DispatchQueue.main.async {
            self.orderMenu.dataSource = dataSource
        }
    }
    
    func setOrder(_ order: String) {
        DispatchQueue.main.async {
            self.orderButton.setTitle(order, for: .normal)
        }
    }
    
    func setDate(from: String, to: String) {
        DispatchQueue.main.async {
            let formater = DateFormatter()
            formater.dateFormat = "yyyy-MM-dd"
            let dateFrom = formater.date(from: from) ?? Date()
            let dateTo = formater.date(from: to) ?? Date()
            
            self.dateFrom.setDate(dateFrom, animated: false)
            self.dateTo.setDate(dateTo, animated: false)
        }
    }
    
    func setPrice(from: Int, to: Int) {
        DispatchQueue.main.async {
            self.priceFrom.text = "\(from)"
            self.priceTo.text = "\(to)"
        }
    }
    
    func setOriginalCityName(_ cityName: String) {
        DispatchQueue.main.async {
            self.origCityName.text = cityName
        }
    }
    
    func setDestinationCityName(_ cityName: String) {
        DispatchQueue.main.async {
            self.destCityName.text = cityName
        }
    }
    
    func getOrder() -> String? {
        return orderMenu.selectedItem
    }
    
    func getDateFrom() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: dateFrom.date)
    }
    
    func getDateTo() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: dateTo.date)
    }
    
    func getPriceFrom() -> Int? {
        return Int(priceFrom.text ?? "a")
    }
    
    func getPriceTo() -> Int? {
        return Int(priceTo.text ?? "a")
    }
    
    func getOriginalCityName() -> String? {
        return origCityName.text
    }
    
    func getDestinationCityName() -> String? {
        return destCityName.text
    }
    
    @objc
    private func goBack() {
        self.presenter?.saveFilters()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func showOrderMenu() {
        self.orderMenu.show()
    }
    
    private func setupView() {
        self.view.backgroundColor = AppColorAppearance.backgroundColor
        
        setupNavigationBar()
        
        setupOrder()
        
        setupDate()
        setupPrice()
        
        setupOriginalCityName()
        setupDestinationCityName()
        
        presenter?.setupFilters()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = NavigationBarAppearance.backgroundColor
        self.navigationController?.navigationBar.isTranslucent = false
        
        let backArrowImage = UIImage(named: "BackArrow")
        let backButton = UIButton()
        backButton.setTitle("Назад", for: .normal)
        backButton.setImage(backArrowImage, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func setupOrder() {
        let safeArea = view.safeAreaLayoutGuide
        
        self.view.addSubview(orderLabel)
        orderLabel.text = LayoutConstants.orderLabelText
        orderLabel.translatesAutoresizingMaskIntoConstraints = false
        orderLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: LayoutConstants.topSpace).isActive = true
        orderLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
        orderLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: LayoutConstants.rightSpace).isActive = true
        
        self.view.addSubview(orderButton)
        orderButton.layer.cornerRadius = safeArea.layoutFrame.width / 60
        orderButton.backgroundColor = MainButtonAppearance.backgroundColor
        orderButton.setTitleColor(MainButtonAppearance.textColor, for: .normal)
        orderButton.addTarget(self, action: #selector(showOrderMenu), for: .touchUpInside)
        
        orderButton.translatesAutoresizingMaskIntoConstraints = false
        orderButton.topAnchor.constraint(equalTo: orderLabel.bottomAnchor, constant: LayoutConstants.topSpace).isActive = true
        orderButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
        orderButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: LayoutConstants.rightSpace).isActive = true
        
        orderMenu.anchorView = orderButton
        orderMenu.selectionAction = { [unowned self] (index: Int, item: String) in
            DispatchQueue.main.async {
                self.orderButton.setTitle(item, for: .normal)
                self.orderMenu.hide()
            }
        }
    }
    
    private func setupDate() {
        let safeArea = view.safeAreaLayoutGuide
        
        self.view.addSubview(dateFromLabel)
        dateFromLabel.text = "Дата отбытия с"
        
        dateFromLabel.translatesAutoresizingMaskIntoConstraints = false
        dateFromLabel.topAnchor.constraint(equalTo: orderButton.bottomAnchor, constant: LayoutConstants.topSpace).isActive = true
        dateFromLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
        dateFromLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: LayoutConstants.rightSpace).isActive = true
        
        self.view.addSubview(dateFrom)
        dateFrom.datePickerMode = .date
        dateFrom.translatesAutoresizingMaskIntoConstraints = false
        dateFrom.topAnchor.constraint(equalTo: dateFromLabel.bottomAnchor, constant: LayoutConstants.topSpace).isActive = true
        dateFrom.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
        
        self.view.addSubview(dateToLabel)
        dateToLabel.text = "Дата отбытия до"
        
        dateToLabel.translatesAutoresizingMaskIntoConstraints = false
        dateToLabel.topAnchor.constraint(equalTo: dateFrom.bottomAnchor, constant: LayoutConstants.topSpace).isActive = true
        dateToLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
        dateToLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: LayoutConstants.rightSpace).isActive = true
        
        self.view.addSubview(dateTo)
        dateTo.datePickerMode = .date
        dateTo.translatesAutoresizingMaskIntoConstraints = false
        dateTo.topAnchor.constraint(equalTo: dateToLabel.bottomAnchor, constant: LayoutConstants.topSpace).isActive = true
        dateTo.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
    }
    
    private func setupPrice() {
        let safeArea = view.safeAreaLayoutGuide
        
        self.view.addSubview(priceLabel)
        priceLabel.text = LayoutConstants.priceLabelText
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: dateTo.bottomAnchor, constant: LayoutConstants.topSpace).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: LayoutConstants.rightSpace).isActive = true
        
        self.view.addSubview(priceFrom)
        priceFrom.placeholder = LayoutConstants.priceFromPlaceholder
        priceFrom.backgroundColor = TextFieldAppearance.backgroungColor
        priceFrom.layer.cornerRadius = LayoutConstants.priceWidth / 20
        priceFrom.setLeftPaddingPoints(TextFieldAppearance.leftPadding)
        priceFrom.setRightPaddingPoints(TextFieldAppearance.rightPadding)
        
        priceFrom.translatesAutoresizingMaskIntoConstraints = false
        priceFrom.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: LayoutConstants.topSpace).isActive = true
        priceFrom.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
        priceFrom.widthAnchor.constraint(equalToConstant: LayoutConstants.priceWidth).isActive = true
        priceFrom.heightAnchor.constraint(equalToConstant: LayoutConstants.priceHeight).isActive = true
        
        self.view.addSubview(priceTo)
        priceTo.placeholder = LayoutConstants.priceToPlaceholder
        priceTo.backgroundColor = TextFieldAppearance.backgroungColor
        priceTo.layer.cornerRadius = LayoutConstants.priceWidth / 20
        priceTo.setLeftPaddingPoints(TextFieldAppearance.leftPadding)
        priceTo.setRightPaddingPoints(TextFieldAppearance.rightPadding)
        
        priceTo.translatesAutoresizingMaskIntoConstraints = false
        priceTo.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: LayoutConstants.topSpace).isActive = true
        priceTo.leftAnchor.constraint(equalTo: priceFrom.rightAnchor, constant: LayoutConstants.betweenLeftSpace).isActive = true
        priceTo.widthAnchor.constraint(equalToConstant: LayoutConstants.priceWidth).isActive = true
        priceTo.heightAnchor.constraint(equalToConstant: LayoutConstants.priceHeight).isActive = true
    }
    
    private func setupOriginalCityName() {
        let safeArea = view.safeAreaLayoutGuide
        
        self.view.addSubview(origCityName)
        origCityName.placeholder = LayoutConstants.origCityNamePlaceholder
        origCityName.backgroundColor = TextFieldAppearance.backgroungColor
        origCityName.layer.cornerRadius = safeArea.layoutFrame.width / 70
        origCityName.setLeftPaddingPoints(TextFieldAppearance.leftPadding)
        origCityName.setRightPaddingPoints(TextFieldAppearance.rightPadding)
        
        origCityName.translatesAutoresizingMaskIntoConstraints = false
        origCityName.topAnchor.constraint(equalTo: priceFrom.bottomAnchor, constant: LayoutConstants.topSpace).isActive = true
        origCityName.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
        origCityName.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: LayoutConstants.rightSpace).isActive = true
        origCityName.heightAnchor.constraint(equalToConstant: LayoutConstants.origCityNameHeight).isActive = true
    }
    
    private func setupDestinationCityName() {
        let safeArea = view.safeAreaLayoutGuide
        
        self.view.addSubview(destCityName)
        destCityName.placeholder = LayoutConstants.destCityNamePlaceholder
        destCityName.backgroundColor = TextFieldAppearance.backgroungColor
        destCityName.layer.cornerRadius = safeArea.layoutFrame.width / 70
        destCityName.setLeftPaddingPoints(TextFieldAppearance.leftPadding)
        destCityName.setRightPaddingPoints(TextFieldAppearance.rightPadding)
        
        destCityName.translatesAutoresizingMaskIntoConstraints = false
        destCityName.topAnchor.constraint(equalTo: origCityName.bottomAnchor, constant: LayoutConstants.topSpace).isActive = true
        destCityName.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
        destCityName.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: LayoutConstants.rightSpace).isActive = true
        destCityName.heightAnchor.constraint(equalToConstant: LayoutConstants.destCityNameHeight).isActive = true
    }
}
