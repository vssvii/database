//
//  AppDelegate.swift
//  FileManager
//
//  Created by Ibragim Assaibuldayev on 01.09.2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
        
        var window: UIWindow?

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            window = UIWindow()
            
            let fileManagerBarItem = UITabBarItem()
            fileManagerBarItem.title = "Файл менеджера"
            fileManagerBarItem.image = UIImage(systemName: "folder")
            let fileManagerService = FileManagerService()
            let content = Content(type: .folder(url: URL(string: "")), name: "")
            let fileManagerViewController = FileManagerViewController(fileManagerService: fileManagerService, content: content)
            fileManagerViewController.tabBarItem = fileManagerBarItem
            let fileManagerNavigationController = UINavigationController(rootViewController: fileManagerViewController)
            
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [fileManagerNavigationController]
            tabBarController.selectedIndex = 0
            window?.rootViewController = tabBarController
            window?.makeKeyAndVisible()
        
        return true
    }
}

