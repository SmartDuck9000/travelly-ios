//
//  OptionsInteractor.swift
//  Travelly
//
//  Created by Георгий Куликов on 11.04.2021.
//

import UIKit

class CityTourInfoOptionsInteractor: CityTourInfoOptionsInteractorProtocol {
    
    private var options: [CityTourInfoOptionData] = []
    
    init() {
        setupOptions()
    }
    
    func optionsCount() -> Int {
        options.count
    }
    
    func getCityTourInfoOptionData(at index: Int) -> CityTourInfoOptionData? {
        if index < 0 || index >= options.count {
            return nil
        }
        
        return options[index]
    }
    
    private func setupOptions() {
        options.append(CityTourInfoOptionData(name: "Отель"))
        options.append(CityTourInfoOptionData(name: "Билет в город"))
        options.append(CityTourInfoOptionData(name: "Билет из города"))
        options.append(CityTourInfoOptionData(name: "События"))
        options.append(CityTourInfoOptionData(name: "Рестораны"))
    }
}
