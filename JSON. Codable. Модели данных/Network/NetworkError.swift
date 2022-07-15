//
//  NetworkError.swift
//  JSON_Decode_Serialization
//
//  Created by Саидов Тимур on 25.05.2022.
//

import Foundation
import UIKit


enum NetworkError: Error {
    
    case `default`
    case serverError
    case parseError(reason: String)
    case unknownError
}
