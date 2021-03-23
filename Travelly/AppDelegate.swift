//
//  AppDelegate.swift
//  Travelly
//
//  Created by Георгий Куликов on 14.02.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    public static let container: DependencyContainerProtocol = SwinjectContainer()
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        registerDependencies()
        
        return true
    }
    
    private func registerDependencies() {
        let serviceRegistrator: DependencyRegistratorProtocol = ServicesRegistrator()
        let authRegistrator: DependencyRegistratorProtocol = AuthAssembly()
        let registerRegistrator: DependencyRegistratorProtocol = RegisterAssembly()
        let loginRegistrator: DependencyRegistratorProtocol = LoginAssembly()
        let profileRegistrator: DependencyRegistratorProtocol = ProfileAssembly()
        
        serviceRegistrator.registerDependencies()
        authRegistrator.registerDependencies()
        registerRegistrator.registerDependencies()
        loginRegistrator.registerDependencies()
        profileRegistrator.registerDependencies()
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

