//
//  AppDelegate.swift
//  FileManager
//
//  Created by Ibragim Assaibuldayev on 01.09.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
        
        var window: UIWindow?

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            window = UIWindow()
            window?.rootViewController = SignInViewController()
            window?.makeKeyAndVisible()
        
        return true
    }


}

