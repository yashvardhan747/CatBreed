//
//  FetchingStatus.swift
//  CatBreeds
//
//  Created by Yash on 01/12/23.
//

protocol Fetchable {
    var urlString: String? { get }
}

enum FetchingStatus<T: Fetchable> {
    case notStarted
    case fetching
    case failed
    case fetched(T)
    
    init(_ data: T?) {
        guard let data = data else {
            self = .notStarted
            return
        }
        self = .fetched(data)
    }
}
