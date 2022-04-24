//
//  AppDelegate.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 19/04/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        let loader = GDDataLoader()
        let listHandler = GDCharacterListHandler(decoder: GDGenericDataDecoder())
        let navigationController = UINavigationController(rootViewController:
                                                            GDMainViewController(loader: loader, listHandler: listHandler)
        )
        // some start setting
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

