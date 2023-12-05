//
//  OptionalObject.swift
//  CatBreeds
//
//  Created by Yash on 05/12/23.
//

struct DecodingFailableObject<T: Decodable>: Decodable {
    let value: Result<T, NetworkError>

    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            let data = try container.decode(T.self)
            value = .success(data)
        } catch {
            self.value = .failure(.decodingError(error))
        }
    }
}
