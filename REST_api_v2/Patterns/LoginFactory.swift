//
//  LoginFactory.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 22.05.2022.
//

import Foundation
import UIKit

protocol LoginFactory {
    
    func getLoginInspector () -> LoginInspector
}

//extension LoginFactory {
//
//    func getLoginInspector () -> LoginInspector {
//        let inspector = LoginInspector()
//        return inspector
//    }
//}

class MyLoginFactory: LoginFactory {
    
    func getLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
