//
//  Breed.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//


struct BreedImage: Fetchable, Codable {
    let referenceImageId: String
    let urlString: String
    
    enum CodingKeys: String, CodingKey {
        case referenceImageId = "id"
        case urlString = "url"
    }
}

struct Breed: Decodable {
    let id: String
    let name: String
    let referenceImageId: String
    let description: String?
    let lifeSpan: String?
    let indoor: Int?
    let adaptibility: Int?
    let affectionLivel: Int?
    let childFriendly: Int?
    let dogFriendly: Int?
    let energyLevel: Int?
    let intelligence: Int?
    var breedImageFetchingStatus: FetchingStatus<BreedImage>
    
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
        let breed = try decoder.container(keyedBy: CodingKeys.self)
        id = try breed.decode(String.self, forKey: .id)
        name = try breed.decode(String.self, forKey: .name)
        referenceImageId = try breed.decode(String.self, forKey: .referenceImageId)
        
        description = try? breed.decode(String.self, forKey: .description)
        lifeSpan = try? breed.decode(String.self, forKey: .lifeSpan)
        indoor = try? breed.decode(Int.self, forKey: .indoor)
        adaptibility = try? breed.decode(Int.self, forKey: .adaptibility)
        affectionLivel = try? breed.decode(Int.self, forKey: .affectionLivel)
        childFriendly = try? breed.decode(Int.self, forKey: .childFriendly)
        dogFriendly = try? breed.decode(Int.self, forKey: .dogFriendly)
        energyLevel = try? breed.decode(Int.self, forKey: .energyLevel)
        intelligence = try? breed.decode(Int.self, forKey: .intelligence)
        
        breedImageFetchingStatus = .notStarted
    }
}
