//
//  UserService.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 10.05.2022.
//

import Foundation

protocol UserService: User {
    
    var name: String {get set}
    var avatar: String {get set}
    var status: String {get set}
    
    
}

extension UserService {
    
    func userNick(name: String) -> User {
        let user = User(name: name, avatar: "", status: "")
        return user
    }
}
