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
        }
    }
    
    
    
    func signUp(with email: String, password: String, completion: @escaping (AuthDataResult?, NSError?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { [self] createResult, error in
            
            completion(createResult, error as NSError?)
        }
    }
}
