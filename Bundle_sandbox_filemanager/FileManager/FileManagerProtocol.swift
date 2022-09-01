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
    
    
    func createDirectory(at pathComponent: String?, completion: @escaping (Result<[URL], FileManagerError>) -> Void) {
        
        let fileManager = FileManager.default
        let desktopURL = try! fileManager.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = desktopURL.appendingPathComponent(pathComponent!)
        
        do {
            let urls = try fileManager.createDirectory(at: fileURL, withIntermediateDirectories: true, attributes: nil)
            completion(.success([fileURL]))
        } catch {
        }
    }
    
    
    
    func createFile(at fileName: String?, completion: @escaping (Result<[URL], FileManagerError>) -> Void) {
        
        let fileManager = FileManager.default
        
        let desktopURL = try! FileManager.default.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        print("desktopURL: " + String(describing: desktopURL))
        let fileURL = desktopURL.appendingPathComponent(fileName!).appendingPathExtension("jpeg")
        
        do {
            let urls = try fileManager.createFile(atPath: fileName!, contents: nil, attributes: nil)
            completion(.success([fileURL]))
        } catch {
            completion(.failure(.fileIsNotFound))
        }
    }
    
    
    
    func contentsOfDirectory(at pathComponent: String?, completion: @escaping (Result<[URL], FileManagerError>) -> Void) {
        
        let fileManager = FileManager.default
        
        do {
            let documentUrl = try fileManager.url(for: .documentDirectory, in: [.userDomainMask], appropriateFor: nil, create: false)
            let urls = try fileManager.contentsOfDirectory(at: documentUrl, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])
            completion(.success(urls))
            
        } catch let error {
            completion(.failure(.unknownError))
        }
    }
}
