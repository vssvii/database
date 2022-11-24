//
//  AppDelegate.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 26.12.2021.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import CoreData


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        let loginInspector = LoginInspector()
        var factory = MyLoginFactory().getLoginInspector()
        
        let feedViewItem = UITabBarItem()
        feedViewItem.title = "Лента пользователя"
        feedViewItem.image = UIImage(systemName: "house.fill")
        let feedView = FeedViewController()
        feedView.title = "Лента пользователя"
        feedView.tabBarItem = feedViewItem
        let feedViewNavigationController = UINavigationController(rootViewController: feedView)
        
        let profileItem = UITabBarItem()
        profileItem.title = "Профиль"
        profileItem.image = UIImage(systemName: "person.fill")
        let profile = LogInViewController(with: factory)
        profile.title = "Профиль"
        profile.tabBarItem = profileItem
        let profileViewNavigationController = UINavigationController(rootViewController: profile)
        
        let likedPostsItem = UITabBarItem()
        likedPostsItem.title = "Посты"
        likedPostsItem.image = UIImage(systemName: "heart.fill")
        let likedPosts = LikedPostsViewController()
        likedPosts.title = "Избранные посты"
        likedPosts.tabBarItem = likedPostsItem
        let likedPostsViewNavigationController = UINavigationController(rootViewController: likedPosts)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [feedViewNavigationController, profileViewNavigationController, likedPostsViewNavigationController]
        tabBarController.selectedIndex = 0
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        if let tabController = window?.rootViewController as? UITabBarController, let loginNavigation = tabController.viewControllers?.last as? UINavigationController, let loginController = loginNavigation.viewControllers.first as? LogInViewController {
            loginController.delegate = loginInspector
            }
        
        FirebaseApp.configure()
        return true
    }
    
    
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        
        let appConfiguration: AppConfiguration = .planets(urlString: "https://swapi.dev/api/planets/5")
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
        
        let profileViewHeader = ProfileHeaderView()
        profileViewHeader.closeButton.addAction(UIAction.init(handler: { action in
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                let logInNavigationController = UINavigationController(rootViewController: logInViewController)
                let navigationController = (self.window?.rootViewController ?? logInNavigationController) as UIViewController
                navigationController.navigationController?.pushViewController(logInViewController, animated: true)
            }
            catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }), for: .touchUpInside)
    }
}
