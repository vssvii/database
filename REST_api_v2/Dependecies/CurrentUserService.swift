//
//  CurrentUserService.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 10.05.2022.
//

import Foundation

class CurrentUserService: User, UserService {
    
    let user = User(name: "Ibragim", avatar: "", status: "")
    
    func currentUser (_ userName: String) -> String {
        if userName == user.name {
            return userName
        } else {
            print("Error!")
        }
        return userName
    }
    

}
