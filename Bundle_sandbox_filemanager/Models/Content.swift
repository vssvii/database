//
//  Content.swift
//  FileManager
//
//  Created by Ibragim Assaibuldayev on 09.09.2022.
//

import Foundation


struct Content: Codable {
    
    
    enum ContentType: Codable, Equatable {
        case folder(url: URL?)
        case file(url: URL?)
        
        var url: URL? {
            switch self {
            case .folder(let url), .file(let url):
                return url
            }
        }
    }
    
    let type: ContentType
    var name: String
    
    
    public init(type: ContentType, name: String) {
        self.name = name
        self.type = type
    }
    
}

extension Content: Equatable {
    
    
    public static func == (lhs: Content, rhs: Content) -> Bool {
        lhs.name == rhs.name &&
        lhs.type == rhs.type
    }
}

final class ContentsStore {
    
    /// Синглтон для изменения состояния привычек из разных модулей.
    public static let shared: ContentsStore = .init()
    
    /// Список привычек, добавленных пользователем. Добавленные привычки сохраняются в UserDefaults и доступны после перезагрузки приложения.
    public var contents: [Content] = [] {
        didSet {
            save()
        }
    }
    
    private lazy var userDefaults: UserDefaults = .standard
    
    private lazy var decoder: JSONDecoder = .init()
    
    private lazy var encoder: JSONEncoder = .init()
    
    
    public func save() {
        do {
            let data = try encoder.encode(contents)
            userDefaults.setValue(data, forKey: "contents")
        }
        catch {
            print("Ошибка кодирования привычек для сохранения", error)
        }
    }

    
    // MARK: - Private
    
    private init() {
        if userDefaults.value(forKey: "start_date") == nil {
            userDefaults.setValue(Date(), forKey: "start_date")
        }
        guard let data = userDefaults.data(forKey: "contents") else {
            return
        }
        do {
            contents = try decoder.decode([Content].self, from: data)
        }
        catch {
            print("Ошибка декодирования сохранённых привычек", error)
        }
    }
}
