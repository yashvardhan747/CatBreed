//
//  PersistencyManager.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//

import UIKit

final class PersistencyManager {
    static let shared = PersistencyManager()
    private init() {}
    
    private let cache = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    
    func saveInCache<T: Encodable>(_ data: T, filename: String) {
        let url = cache.appendingPathComponent("\(filename).json")
        guard let encodedData = try? JSONEncoder().encode(data) else {return}
        
        if !FileManager.default.fileExists(atPath: url.path) {
            FileManager.default.createFile(atPath: url.path, contents: encodedData)
        }
    }
    
    func getFromCache<T: Decodable>(filename: String) -> T? {
        let url = cache.appendingPathComponent("\(filename).json")
        guard let data = try? Data(contentsOf: url) else {return nil}
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {return nil}
        return decodedData
    }
}

