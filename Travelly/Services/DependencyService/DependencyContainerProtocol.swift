//
//  DependencyContainerProtocol.swift
//  Travelly
//
//  Created by Георгий Куликов on 20.02.2021.
//

import Swinject

protocol DependencyContainerProtocol: AnyObject {
    func register<Service>(service: Service.Type, name: String, factory: @escaping () -> Service)
    func register<Service, Arg>(service: Service.Type, name: String, factory: @escaping (Arg) -> Service)
    func register<Service, Arg1, Arg2>(service: Service.Type, name: String, factory: @escaping (Arg1, Arg2) -> Service)
    
    func resolve<Service>(service: Service.Type, name: String) -> Service?
    func resolve<Service, Arg>(service: Service.Type, name: String, argument arg: Arg) -> Service?
    func resolve<Service, Arg1, Arg2>(service: Service.Type, name: String, arguments arg1: Arg1, _ arg2: Arg2) -> Service?
}
