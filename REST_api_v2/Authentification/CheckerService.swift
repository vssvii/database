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
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error as? NSError {
                print("Error: \(error.localizedDescription)")
            } else {
                let logInProfile = ProfileViewController(userService: CurrentUserService(name: email, avatar: "", status: "") as UserService, userName: email)
                self.navigationController?.pushViewController(logInProfile, animated: true)
                print("User signs in successfully")
                let userInfo = Auth.auth().currentUser
                let email = userInfo?.email
            }
        }
    }
    
    
    
    func signUp(with email: String, password: String, completion: @escaping (AuthDataResult?, NSError?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { createResult, error in
            if let error = error as? NSError {
                print("Error: \(error.localizedDescription)")
            } else {
                print("User signs up successfully")
                let newUserInfo = Auth.auth().currentUser
                let email = newUserInfo?.email
            }
         }
    }
}
