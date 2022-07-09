//
//  NetworkService.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 05.07.2022.
//

import Foundation
import UIKit

struct NetworkManager {
    
    static func equest(for configuration: AppConfiguration) {
        
        let url: URL
        
        switch configuration {
        case .people(let urlString):
            url = URL(string: urlString)!
            
        case .starships(urlString: let urlString):
            url = URL(string: urlString)!
            
        case .planets(urlString: let urlString):
            url = URL(string: urlString)!
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            
            print("Server's data is: \(String(describing: data))")
            
            print("Server's response is: \(String(describing: response))")
            
            print("Server's error is: \(String(describing: error?.localizedDescription))")
            
            }

            task.resume()
    }
}

