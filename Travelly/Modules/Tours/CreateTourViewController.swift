//
//  CreateTourViewController.swift
//  Travelly
//
//  Created by Георгий Куликов on 28.08.2021.
//

import UIKit

class CreateTourViewController: UIViewController {
    
    var presenter: ToursPresenterProtocol?
    
    private var nameTextField = UITextField()
    private var fromDateLabel = UILabel()
    private var fromDatePicker = UIDatePicker()
    private var toDateLabel = UILabel()
    private var toDatePicker = UIDatePicker()
    private var createTourButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc
    func createTourButtonDidTap() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let newTourData = PostedTourModel(
            id: 0,
            user_id: 0,
            tour_name: nameTextField.text ?? "",
            tour_price: 0.0,
            tour_date_from: formatter.string(from: fromDatePicker.date),
            tour_date_to: formatter.string(from: toDatePicker.date)
        )
        
        dismiss(animated: true) {
            guard newTourData.tour_name != "" else { return }
            self.presenter?.addTour(with: newTourData)
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        setupNameTextField()
        setupFromDate()
        setupToDate()
        setupCreateTourButton()
    }
    
    private func setupNameTextField() {
        nameTextField.placeholder = "Название"
        nameTextField.setLeftPaddingPoints(10)
        
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        nameTextField.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 15
        ).isActive = true
        nameTextField.leftAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leftAnchor,
            constant: 10
        ).isActive = true
        nameTextField.rightAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.rightAnchor,
            constant: -10
        ).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupFromDate() {
        view.addSubview(fromDateLabel)
        fromDateLabel.translatesAutoresizingMaskIntoConstraints = false
        fromDateLabel.text = "Дата начала:"
        
        fromDateLabel.topAnchor.constraint(
            equalTo: nameTextField.bottomAnchor,
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
    
    private func setupCreateTourButton() {
        createTourButton.addTarget(self, action: #selector(createTourButtonDidTap), for: .touchUpInside)
        createTourButton.setTitle("Создать тур", for: .normal)
        createTourButton.backgroundColor = .systemOrange
        createTourButton.layer.cornerRadius = (view.frame.width - 20) / 30
        
        view.addSubview(createTourButton)
        createTourButton.translatesAutoresizingMaskIntoConstraints = false
        
        createTourButton.topAnchor.constraint(
            equalTo: toDatePicker.bottomAnchor,
            constant: 15
        ).isActive = true
        createTourButton.leftAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leftAnchor,
            constant: 10
        ).isActive = true
        createTourButton.rightAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.rightAnchor,
            constant: -10
        ).isActive = true
        createTourButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
