//
//  DependencyContainer.swift
//  Travelly
//
//  Created by Георгий Куликов on 20.02.2021.
//

import Swinject


class SwinjectContainer: DependencyContainerProtocol {
    private let container = Container()
    
    public func register<Service>(service: Service.Type, name: String, factory: @escaping () -> Service) {
        container.register(service, name: name) { _ in
            factory()
        }
    }
    
    public func register<Service, Arg>(service: Service.Type, name: String, factory: @escaping (Arg) -> Service) {
        container.register(service, name: name) { (_, arg) -> Service in
            factory(arg)
        }
    }
    
    public func register<Service, Arg1, Arg2>(service: Service.Type, name: String, factory: @escaping (Arg1, Arg2) -> Service) {
        container.register(service, name: name) { (_, arg1, arg2) -> Service in
            factory(arg1, arg2)
        }
    }
    
    public func resolve<Service>(service: Service.Type, name: String) -> Service? {
        return container.resolve(service, name: name)
    }
    
    public func resolve<Service, Arg>(service: Service.Type, name: String, argument arg: Arg) -> Service? {
        return container.resolve(service, name: name, argument: arg)
    }
    
    public func resolve<Service, Arg1, Arg2>(service: Service.Type, name: String, arguments arg1: Arg1, _ arg2: Arg2) -> Service? {
        return container.resolve(service, name: name, arguments: arg1, arg2)
    }
}