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
        var registrators: [DependencyRegistratorProtocol] = []
        
        registrators.append(ServicesRegistrator())
        
        registrators.append(AuthAssembly())
        registrators.append(RegisterAssembly())
        registrators.append(LoginAssembly())
        
        registrators.append(ToursAssembly())
        registrators.append(CityToursAssembly())
        registrators.append(CityTourInfoAssembly())
        
        registrators.append(CityTourHotelAssembly())
        registrators.append(CityTourTicketsAssembly())
        
        registrators.append(ProfileAssembly())
        registrators.append(EditProfileAssembly())
        
        registrators.append(HotelFeedAssembly())
        registrators.append(HotelFilterAssembly())
        registrators.append(HotelInfoAssembly())
        
        registrators.append(RestaurantsFeedAssembly())
        registrators.append(RestaurantsFilterAssembly())
        registrators.append(RestaurantInfoAssembly())
        
        registrators.append(TicketsFeedAssembly())
        registrators.append(TicketsFilterAssembly())
        registrators.append(TicketInfoAssembly())
        
        registrators.append(EventsFeedAssembly())
        registrators.append(EventsFilterAssembly())
        registrators.append(EventInfoAssembly())
        
        for registrator in registrators {
            registrator.registerDependencies()
        }
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

