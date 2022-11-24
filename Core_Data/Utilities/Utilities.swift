//
//  Utilities.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 01.08.2022.
//

import Foundation
import UIKit

public class Utilities {
    
    
    static func isPasswordValid(_ password: String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$")
        return passwordTest.evaluate(with: password)
    }
}
