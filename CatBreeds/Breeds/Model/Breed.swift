//
//  Breed.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//

struct BreedImage: Codable {
    let referenceImageId: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case referenceImageId = "id"
        case imageUrl = "url"
    }
    
    init(from decoder: Decoder) throws {
        guard let breedImage = try? decoder.container(keyedBy: CodingKeys.self) else {
            throw NetworkingError.invalidResponse
        }
        
        referenceImageId = (try? breedImage.decode(String.self, forKey: .referenceImageId)) ?? ""
        imageUrl = (try? breedImage.decode(String.self, forKey: .imageUrl)) ?? ""
    }
}
    
struct Breed: Codable {
    let id: String
    let name: String
    let referenceImageId: String
    let description: String
    let lifeSpan: String
    let indoor: Int
    let adaptibility: Int
    let affectionLivel: Int
    let childFriendly: Int
    let dogFriendly: Int
    let energyLevel: Int
    let intelligence: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case referenceImageId = "reference_image_id"
        case description = "description"
        case lifeSpan = "life_span"
        case indoor = "indoor"
        case adaptibility = "adaptability"
        case affectionLivel = "affection_level"
        case childFriendly = "child_friendly"
        case dogFriendly = "dog_friendly"
        case energyLevel = "energy_level"
        case intelligence = "intelligence"
    
    }
    
    init(from decoder: Decoder) throws {
        guard let breed = try? decoder.container(keyedBy: CodingKeys.self) else {
            throw NetworkingError.invalidResponse
        }
        
        id = (try? breed.decode(String.self, forKey: .id)) ?? ""
        name = (try? breed.decode(String.self, forKey: .name)) ?? ""
        referenceImageId = (try? breed.decode(String.self, forKey: .referenceImageId)) ?? ""
        description = (try? breed.decode(String.self, forKey: .description)) ?? ""
        lifeSpan = (try? breed.decode(String.self, forKey: .lifeSpan)) ?? "0"
        indoor = (try? breed.decode(Int.self, forKey: .indoor)) ?? 0
        adaptibility = (try? breed.decode(Int.self, forKey: .adaptibility)) ?? 0
        affectionLivel = (try? breed.decode(Int.self, forKey: .affectionLivel)) ?? 0
        childFriendly = (try? breed.decode(Int.self, forKey: .childFriendly)) ?? 0
        dogFriendly = (try? breed.decode(Int.self, forKey: .dogFriendly)) ?? 0
        energyLevel = (try? breed.decode(Int.self, forKey: .energyLevel)) ?? 0
        intelligence = (try? breed.decode(Int.self, forKey: .intelligence)) ?? 0
    }
}
