//
//  UserDefaults+Extension.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

import Foundation

extension UserDefaults {
    func set<T: Codable>(object: T, forKey key: String) throws {
        let jsonEncoder: JSONEncoder = .init()
        let jsonData = try jsonEncoder.encode(object)
        set(jsonData, forKey: key)
    }
    
    func getObject<T: Codable>(ofType type: T.Type, forKey key: String) throws -> T? {
        guard let data = data(forKey: key) else { return nil }
        let jsonDecoder: JSONDecoder = .init()
        let object = try jsonDecoder.decode(type, from: data)
        return object
    }
}
