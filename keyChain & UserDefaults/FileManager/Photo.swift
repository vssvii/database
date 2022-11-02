//
//  Photo.swift
//  FileManager
//
//  Created by Ibragim Assaibuldayev on 08.09.2022.
//



import UIKit

class Photo: NSObject, NSCoding {
    var name: String
    var photo: String
    
    init(name: String, photo: String) {
        self.name = name
        self.photo = photo
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        photo = aDecoder.decodeObject(forKey: "photo") as? String ?? ""
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(photo, forKey: "photo")
    }
}
