//
//  LoginViewControllerDelegate.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 20.05.2022.
//

import Foundation
import UIKit

protocol LoginViewControllerDelegate {
    
    func logInChecker(userName: String, password: String) -> Bool

}

class LoginInspector: LoginViewControllerDelegate {
    func logInChecker(userName: String, password: String) -> Bool {
        if userName == Checker.shared.login && password == Checker.shared.pswd {
            return true
        } else {
            return false
        }
    }
}
