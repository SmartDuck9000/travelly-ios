//
//  CreateCityTourViewController.swift
//  Travelly
//
//  Created by Георгий Куликов on 28.08.2021.
//

import UIKit
import DropDown

class CreateCityTourViewController: UIViewController {
    
    var presenter: CityToursPresenterProtocol?
    
    private var cityPicker = UIPickerView()
    private var fromDateLabel = UILabel()
    private var fromDatePicker = UIDatePicker()
    private var toDateLabel = UILabel()
    private var toDatePicker = UIDatePicker()
    private var createCityTourButton = UIButton()
    
    var cities: [CityData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadCities(completion: { (data) in
            self.cities = data
            self.cityPicker.reloadAllComponents()
        })
        self.setupView()
    }
    
    @objc
    func createCityTourButtonDidTap() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let newCityTourData = PostedCityTourModel(
            id: -1,
            tour_id: 0,
            city_id: cities[cityPicker.selectedRow(inComponent: 0)].city_id,
            city_tour_price: 0.0,
            date_from: formatter.string(from: fromDatePicker.date),
            date_to: formatter.string(from: toDatePicker.date),
            ticket_arrival_id: 0,
            ticket_departure_id: 0,
            hotel_id: 0
        )
        
        dismiss(animated: true) {
            self.presenter?.addCityTour(with: newCityTourData)
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        setupCityPicker()
        setupFromDate()
        setupToDate()
        setupCreateCityTourButton()
    }
    
    private func setupCityPicker() {
        view.addSubview(cityPicker)
        cityPicker.translatesAutoresizingMaskIntoConstraints = false
        cityPicker.dataSource = self
        cityPicker.delegate = self
        
        cityPicker.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 15
        ).isActive = true
        cityPicker.leftAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leftAnchor,
            constant: 10
        ).isActive = true
        cityPicker.rightAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.rightAnchor,
            constant: -10
        ).isActive = true
    }
    
    private func setupFromDate() {
        view.addSubview(fromDateLabel)
        fromDateLabel.translatesAutoresizingMaskIntoConstraints = false
        fromDateLabel.text = "Дата начала:"
        
        fromDateLabel.topAnchor.constraint(
            equalTo: cityPicker.bottomAnchor,
            constant: 5
        ).isActive = true
        fromDateLabel.leftAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leftAnchor,
            constant: 10
        ).isActive = true
        fromDateLabel.rightAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.rightAnchor,
            constant: -10
        ).isActive = true
        fromDateLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(fromDatePicker)
        fromDatePicker.translatesAutoresizingMaskIntoConstraints = false
        fromDatePicker.datePickerMode = .date
        
        fromDatePicker.topAnchor.constraint(
            equalTo: fromDateLabel.bottomAnchor,
            constant: 5
        ).isActive = true
        fromDatePicker.leftAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leftAnchor,
            constant: 10
        ).isActive = true
        fromDatePicker.rightAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.rightAnchor,
            constant: -10
        ).isActive = true
    }
    
    private func setupToDate() {
        view.addSubview(toDateLabel)
        toDateLabel.translatesAutoresizingMaskIntoConstraints = false
        toDateLabel.text = "Дата окончания:"
        
        toDateLabel.topAnchor.constraint(
            equalTo: fromDatePicker.bottomAnchor,
            constant: 5
        ).isActive = true
        toDateLabel.leftAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leftAnchor,
            constant: 10
        ).isActive = true
        toDateLabel.rightAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.rightAnchor,
            constant: -10
        ).isActive = true
        toDateLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(toDatePicker)
        toDatePicker.translatesAutoresizingMaskIntoConstraints = false
        toDatePicker.datePickerMode = .date
        
        toDatePicker.topAnchor.constraint(
            equalTo: toDateLabel.bottomAnchor,
            constant: 5
        ).isActive = true
        toDatePicker.leftAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leftAnchor,
            constant: 10
        ).isActive = true
        toDatePicker.rightAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.rightAnchor,
            constant: -10
        ).isActive = true
    }
    
    private func setupCreateCityTourButton() {
        createCityTourButton.addTarget(self, action: #selector(createCityTourButtonDidTap), for: .touchUpInside)
        createCityTourButton.setTitle("Создать тур по городу", for: .normal)
        createCityTourButton.backgroundColor = .systemOrange
        createCityTourButton.layer.cornerRadius = (view.frame.width - 20) / 30
        
        view.addSubview(createCityTourButton)
        createCityTourButton.translatesAutoresizingMaskIntoConstraints = false
        
        createCityTourButton.topAnchor.constraint(
            equalTo: toDatePicker.bottomAnchor,
            constant: 15
        ).isActive = true
        createCityTourButton.leftAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leftAnchor,
            constant: 10
        ).isActive = true
        createCityTourButton.rightAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.rightAnchor,
            constant: -10
        ).isActive = true
        createCityTourButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

extension CreateCityTourViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        cities.count
    }
}

extension CreateCityTourViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row].city_name
    }
}
