//
//  Error.swift
//  CatBreeds
//
//  Created by Astrotalk on 29/11/23.
//

enum NetworkingError: Error {
    case invalidData
    case invalidResponse
    case invalidRequest
    case message(_ error: Error?)
}
