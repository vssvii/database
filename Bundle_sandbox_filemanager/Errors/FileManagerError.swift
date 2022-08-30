//
//  FileManagerError.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 11.08.2022.
//

import UIKit


enum FileManagerError: Error {
    
    case invalidPath
    case fileIsNotFound
    case unknownError
}

extension FileManagerError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .invalidPath:
            return NSLocalizedString("Неизвестный путь", comment: "")
        case .fileIsNotFound:
            return NSLocalizedString("Файл не найден", comment: "")
        case .unknownError:
            return NSLocalizedString("Неизвестная ошибка", comment: "")
        }
    }
}
