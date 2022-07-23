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

class CheckerService: CheckerServiceProtocol {
    
    static let shared = CheckerService()
    
    private init() {}
    
    func checkCredentials(email: String, password: String, completion: @escaping (AuthDataResult?, NSError?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error as? NSError {
                print("Error: \(error.localizedDescription)")
            } else {
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


//enum SignMethod {
//    case checkCredentials
//    case signUp
//}
//
//final class CheckerService {
//
//    static let shared = CheckerService()
//
//    private init() {}
//
//    var completion: ((_ message: String) -> Void)?
//
//
//    public func checkUser (SignMethod: SignMethod, login: String, password: String) {
//
//            switch SignMethod {
//            case .checkCredentials:
//                Auth.auth().signIn(withEmail: login, password: password) { [weak self] authResult, error in
//                    guard let strongSelf = self else { return }
//                    if let error = error {
//                        if let completion = strongSelf.completion {
//                            completion (error.localizedDescription)
//                        }
//                    }
//                }
//            case .signUp:
//                Auth.auth().createUser(withEmail: login, password: password) { [weak self] authResult, error in
//                    guard let strongSelf = self else { return }
//                    if let error = error {
//                        if let completion = strongSelf.completion {
//                            completion (error.localizedDescription)
//                        }
//                    }
//                }
//            }
//        }
//}
