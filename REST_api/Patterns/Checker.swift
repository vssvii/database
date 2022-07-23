//
//  Checker.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 20.05.2022.
//

import Foundation
import UIKit

class Checker {
    
    static let shared = Checker()
    let login = "Vasily"
    let pswd = "StrongPassword"
    
    func checkAuth(_ userName: String, _ password: String) -> Bool {
        return userName == login && password == pswd
    }
}
