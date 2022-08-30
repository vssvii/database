//
//  Content.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 11.08.2022.
//

import UIKit

struct Content {
    
    enum ContentType {
        case folder(url: URL?)
        case file(url: URL?)
        var url: URL? {
            switch self {
            case .folder(let url), .file(let url):
                return url }
        }
    }
    
    let type: ContentType
    let name: String
}
 
