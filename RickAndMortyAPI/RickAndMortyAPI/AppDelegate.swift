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
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

