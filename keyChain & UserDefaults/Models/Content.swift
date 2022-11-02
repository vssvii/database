//
//  Content.swift
//  FileManager
//
//  Created by Ibragim Assaibuldayev on 01.09.2022.
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
    var name: String

    
//    required init(coder aDecoder: NSCoder) {
//        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
//        type = aDecoder.decodeObject(forKey: "type") as? ContentType ?? ContentType.folder(url: URL(string: ""))
//    }
//
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(name, forKey: "name")
//        aCoder.encode(type, forKey: "type")
//    }
}
 
