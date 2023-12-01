//
//  Error.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//

enum NetworkingError: Error {
    case invalidData
    case invalidResponse
    case invalidRequest
    case decodingError
}

