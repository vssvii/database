//
//  LoginViewControllerDelegate.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 20.05.2022.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

protocol LoginViewControllerDelegate {
    
    func signUp (login: String, password: String, completion: @escaping (AuthDataResult?, NSError?) -> Void)
    
    func checkCredentials (login: String, password: String, completion: @escaping (AuthDataResult?, NSError?) -> Void)

}

final class LoginInspector: UIViewController, LoginViewControllerDelegate {
    
    
    func signUp (login: String, password: String, completion: @escaping (AuthDataResult?, NSError?) -> Void) {
        
        CheckerService.shared.signUp(with: login, password: password) { result, error in
            if let error = error as? NSError {
                print("Error: \(error.localizedDescription)")
            } else {
                print("User signs up successfully")
                
            }
        }
    }
    
    func checkCredentials (login: String, password: String, completion: @escaping (AuthDataResult?, NSError?) -> Void) {
        
        CheckerService.shared.checkCredentials(email: login, password: password) { result, error in
            if let error = error as? NSError {
                print("Error: \(error.localizedDescription)")
            } else {
                let logInProfile = ProfileViewController(userService: CurrentUserService(name: login, avatar: "", status: "") as UserService, userName: login)
                self.navigationController?.pushViewController(logInProfile, animated: true)
                print("User signs in successfully")
            }
        }
    
    }
}
