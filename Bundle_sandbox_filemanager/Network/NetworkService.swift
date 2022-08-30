//
//  NetworkService.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 05.07.2022.
//

import Foundation
import UIKit

struct NetworkManager {
    
    static func request (for configuration: AppConfiguration) {
        
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

protocol NetworkServiceProtocol {
    func requestJSON(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

final class NetworkService {
    
    private let mainQueue = DispatchQueue.main
}

extension NetworkService: NetworkServiceProtocol {
    
    func requestJSON(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard error == nil else {
                self.mainQueue.async { completion(.failure(.default)) }
                return
            }
            
            guard let data = data else {
                self.mainQueue.async { completion(.failure(.unknownError)) }
                return
            }
            
            self.mainQueue.async { completion(.success(data)) }
        })
        
        task.resume()
    }
}


