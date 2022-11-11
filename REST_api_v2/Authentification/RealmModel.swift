//
//  RealmModel.swift
//  Navigation_2
//
//  Created by Developer on 10.11.2022.
//

import Foundation
import RealmSwift

class AuthRealm: Object {
    
    @Persisted var userName: String
    @Persisted var password: String
}
