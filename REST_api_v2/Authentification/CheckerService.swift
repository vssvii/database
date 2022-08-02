//
//  CheckerServiceProtocol.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 19.07.2022.
//

import Foundation
import Firebase
import FirebaseAuth


protocol CheckerServiceProtocol {
    
    func checkCredentials(email: String, password: String, completion: @escaping (AuthDataResult?, NSError?) ->
    Void)
    
    func signUp(with email: String, password: String, completion: @escaping (AuthDataResult?, NSError?) -> Void)
}

class CheckerService: UIViewController, CheckerServiceProtocol {
    
    static let shared = CheckerService()
    
    private init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func checkCredentials(email: String, password: String, completion: @escaping (AuthDataResult?, NSError?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            completion(authResult, error as NSError?)
//            guard let strongSelf = self else {
//                return
//            }
//
//            guard error == nil else {
//                print("Error: \(String(describing: error?.localizedDescription))")
//                return
//            }
//            print("User signs in successfully")
////            let logInProfile = ProfileViewController(userService: CurrentUserService(name: email, avatar: "", status: "") as UserService, userName: email)
//            let feedView = FeedViewController()
//            strongSelf.navigationController?.pushViewController(feedView, animated: true)
//            let userInfo = Auth.auth().currentUser
//            let email = userInfo?.email
            
        }
    }
    
    
    
    func signUp(with email: String, password: String, completion: @escaping (AuthDataResult?, NSError?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { [self] createResult, error in
            completion(createResult, error as NSError?)
            
//            if error != nil {
////            if let error = error as? NSError {
//                print("Error: \(String(describing: error?.localizedDescription))")
//            } else {
//                print("User signs up successfully")
//                let newUserInfo = Auth.auth().currentUser
//                let email = newUserInfo?.email
//            }
        }
    }
    
//    func checkUserInfo() {
//        if Auth.auth().currentUser != nil {
//            print(Auth.auth().currentUser?.uid as Any)
//            let logInProfile = ProfileViewController(userService: CurrentUserService(name: "", avatar: "", status: "") as UserService, userName: "")
//            navigationController?.pushViewController(logInProfile, animated: true)
//        }
//    }
    
}
