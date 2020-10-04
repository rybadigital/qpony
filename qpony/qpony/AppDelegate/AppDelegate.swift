//
//  AppDelegate.swift
//  qpony
//
//  Created by Tomek Rybkowski on 03/10/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainScreen = MainScreenViewController()

        let navigationController = UINavigationController(rootViewController: mainScreen)
        window?.rootViewController = navigationController
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

