//
//  FileManagerProtocol.swift
//  FileManager
//
//  Created by Ibragim Assaibuldayev on 01.09.2022.
//

import UIKit

protocol FileManagerServiceProtocol {
    
    
    func contentsOfDirectory (at pathComponent: String?, completion: @escaping (Result<[URL], FileManagerError>) -> Void)
    
    func createFile (at pathComponent: String?, completion: @escaping (Result<[URL], FileManagerError>) -> Void)
    
    func createDirectory (at pathComponent: String?, completion: @escaping (Result<[URL], FileManagerError>) -> Void)
}



class FileManagerService: FileManagerServiceProtocol {
    
    let fileManager = FileManager.default
    
    var contentData: NSArray = []
    
    func createDirectory(at pathComponent: String?, completion: @escaping (Result<[URL], FileManagerError>) -> Void) {
        
        let desktopURL = try! fileManager.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = desktopURL.appendingPathComponent(pathComponent!)
        
        completion(.success([fileURL]))
        completion(.failure(.invalidPath))
    }
    
    
    
    func createFile(at fileName: String?, completion: @escaping (Result<[URL], FileManagerError>) -> Void) {
        
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let fileURL = url.appendingPathComponent(fileName!)
        completion(.success([fileURL]))
        completion(.failure(.fileIsNotFound))
    }
    
    
    
    func contentsOfDirectory(at pathComponent: String?, completion: @escaping (Result<[URL], FileManagerError>) -> Void) {
        
        
        do {
            let documentUrl = try fileManager.url(for: .documentDirectory, in: [.userDomainMask], appropriateFor: nil, create: false)
            
            contentData = try fileManager.contentsOfDirectory(at: documentUrl, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles]) as NSArray
            completion(.success(contentData as! [URL]))
            
        } catch let error {
            completion(.failure(.unknownError))
        }
    }
}
