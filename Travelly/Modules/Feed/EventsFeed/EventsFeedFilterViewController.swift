//
//  EventsFeedFilterViewController.swift
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
    
    static let dateLabelText = "Дата проведения"
    static let dateFromPlaceholder = "С"
    static let dateToPlaceholder = "До"
    static let dateWidth: CGFloat = 60
    static let dateHeight: CGFloat = 25
    
    static let ratingLabelText = "Рейтинг"
    static let ratingFromPlaceholder = "От"
    static let ratingToPlaceholder = "До"
    static let ratingWidth: CGFloat = 60
    static let ratingHeight: CGFloat = 25
    
    static let priceLabelText = "Цена"
    static let priceFromPlaceholder = "От"
    static let priceToPlaceholder = "До"
    static let priceWidth: CGFloat = 80
    static let priceHeight: CGFloat = 25
    
    static let cityNamePlaceholder = "Город"
    static let cityNameHeight: CGFloat = 30
}

class EventsFeedFilterViewController: UIViewController {
    
    private var presenter: EventsFilterPresenterProtocol?
    
    private let orderLabel = UILabel()
    private let orderButton = UIButton()
    private let orderMenu = DropDown()
    
    private let dateFromLabel = UILabel()
    private let dateFrom = UIDatePicker()
    private let dateToLabel = UILabel()
    private let dateTo = UIDatePicker()
    
    private let ratingLabel = UILabel()
    private let ratingFrom = UITextField()
    private let ratingTo = UITextField()
    
    private let priceLabel = UILabel()
    private let priceFrom = UITextField()
    private let priceTo = UITextField()
    
    private let cityName = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func set(_ presenter: EventsFilterPresenterProtocol) {
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
    
    func setRating(from: Double, to: Double) {
        DispatchQueue.main.async {
            self.ratingFrom.text = "\(from)"
            self.ratingTo.text = "\(to)"
        }
    }
    
    func setPrice(from: Int, to: Int) {
        DispatchQueue.main.async {
            self.priceFrom.text = "\(from)"
            self.priceTo.text = "\(to)"
        }
    }
    
    func setCityName(_ cityName: String) {
        DispatchQueue.main.async {
            self.cityName.text = cityName
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
    
    func getRatingFrom() -> Double? {
        return Double(ratingFrom.text ?? "a")
    }
    
    func getRatingTo() -> Double? {
        return Double(ratingTo.text ?? "a")
    }
    
    func getPriceFrom() -> Int? {
        return Int(priceFrom.text ?? "a")
    }
    
    func getPriceTo() -> Int? {
        return Int(priceTo.text ?? "a")
    }
    
    func getCityName() -> String? {
        return cityName.text
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
        setupRating()
        setupPrice()
        
        setupCityName()
        
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
        dateFromLabel.text = "Дата начала"
        
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
        dateToLabel.text = "Дата окончания"
        
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
    
    private func setupRating() {
        let safeArea = view.safeAreaLayoutGuide
        
        self.view.addSubview(ratingLabel)
        ratingLabel.text = LayoutConstants.ratingLabelText
        
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.topAnchor.constraint(equalTo: dateTo.bottomAnchor, constant: LayoutConstants.topSpace).isActive = true
        ratingLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
        ratingLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: LayoutConstants.rightSpace).isActive = true
        
        self.view.addSubview(ratingFrom)
        ratingFrom.placeholder = LayoutConstants.ratingFromPlaceholder
        ratingFrom.backgroundColor = TextFieldAppearance.backgroungColor
        ratingFrom.layer.cornerRadius = LayoutConstants.ratingWidth / 15
        ratingFrom.setLeftPaddingPoints(TextFieldAppearance.leftPadding)
        ratingFrom.setRightPaddingPoints(TextFieldAppearance.rightPadding)
        
        ratingFrom.translatesAutoresizingMaskIntoConstraints = false
        ratingFrom.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: LayoutConstants.topSpace).isActive = true
        ratingFrom.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
        ratingFrom.widthAnchor.constraint(equalToConstant: LayoutConstants.ratingWidth).isActive = true
        ratingFrom.heightAnchor.constraint(equalToConstant: LayoutConstants.ratingHeight).isActive = true
        
        self.view.addSubview(ratingTo)
        ratingTo.placeholder = LayoutConstants.ratingToPlaceholder
        ratingTo.backgroundColor = TextFieldAppearance.backgroungColor
        ratingTo.layer.cornerRadius = LayoutConstants.ratingWidth / 15
        ratingTo.setLeftPaddingPoints(TextFieldAppearance.leftPadding)
        ratingTo.setRightPaddingPoints(TextFieldAppearance.rightPadding)
        
        ratingTo.translatesAutoresizingMaskIntoConstraints = false
        ratingTo.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: LayoutConstants.topSpace).isActive = true
        ratingTo.leftAnchor.constraint(equalTo: ratingFrom.rightAnchor, constant: LayoutConstants.betweenLeftSpace).isActive = true
        ratingTo.widthAnchor.constraint(equalToConstant: LayoutConstants.ratingWidth).isActive = true
        ratingTo.heightAnchor.constraint(equalToConstant: LayoutConstants.ratingHeight).isActive = true
    }
    
    private func setupPrice() {
        let safeArea = view.safeAreaLayoutGuide
        
        self.view.addSubview(priceLabel)
        priceLabel.text = LayoutConstants.priceLabelText
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: ratingFrom.bottomAnchor, constant: LayoutConstants.topSpace).isActive = true
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
    
    private func setupCityName() {
        let safeArea = view.safeAreaLayoutGuide
        
        self.view.addSubview(cityName)
        cityName.placeholder = LayoutConstants.cityNamePlaceholder
        cityName.backgroundColor = TextFieldAppearance.backgroungColor
        cityName.layer.cornerRadius = safeArea.layoutFrame.width / 70
        cityName.setLeftPaddingPoints(TextFieldAppearance.leftPadding)
        cityName.setRightPaddingPoints(TextFieldAppearance.rightPadding)
        
        cityName.translatesAutoresizingMaskIntoConstraints = false
        cityName.topAnchor.constraint(equalTo: priceFrom.bottomAnchor, constant: LayoutConstants.topSpace).isActive = true
        cityName.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
        cityName.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: LayoutConstants.rightSpace).isActive = true
        cityName.heightAnchor.constraint(equalToConstant: LayoutConstants.cityNameHeight).isActive = true
    }
}
