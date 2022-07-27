//
//  TestUserService.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 11.05.2022.
//

import UIKit

class TestUserService: User, UserService {
    
    let user = User(name: "Test", avatar: "", status: "")
    
    func currentUser (_ userName: String) -> String {
        if userName == user.name {
            return userName
        } else {
            print("Error!")
        }
        return userName
    }
}
