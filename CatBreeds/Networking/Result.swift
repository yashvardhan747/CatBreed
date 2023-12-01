//
//  Result.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//

enum Result<T: Decodable> {
    case success(T)
    case failure(NetworkingError)
}


