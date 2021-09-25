//
//  OptionsInteractor.swift
//  Travelly
//
//  Created by Георгий Куликов on 11.04.2021.
//

import UIKit

class OptionsInteractor: OptionsInteractorProtocol {
    
    private var options: [ProfileOptionData] = []
    
    init() {
        setupOptions()
    }
    
    func optionsCount() -> Int {
        options.count
    }
    
    func getProfileOptionData(at index: Int) -> ProfileOptionData? {
        if index < 0 || index >= options.count {
            return nil
        }
        
        return options[index]
    }
    
    private func setupOptions() {
        options.append(ProfileOptionData(name: "Редактировать профиль"))
        options.append(ProfileOptionData(name: "Мои туры"))
        options.append(ProfileOptionData(name: "Отели"))
        options.append(ProfileOptionData(name: "Рестораны"))
        options.append(ProfileOptionData(name: "События"))
        options.append(ProfileOptionData(name: "Билеты"))
        options.append(ProfileOptionData(name: "Выйти"))
    }
}
