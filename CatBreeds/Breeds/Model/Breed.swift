//
//  Breed.swift
//  CatBreeds
//
//  Created by Astrotalk on 29/11/23.
//

typealias BreedData = (title: String, value: String)

struct Breed: Codable {
    let id: String
    let name: String
    let imageUrl: String
    let wikipediaUrl: String
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
        case imageUrl = "imageUlmnlwenfrl"
        case wikipediaUrl = "wikipedia_url"
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
        imageUrl = (try? breed.decode(String.self, forKey: .imageUrl)) ?? "https://placekitten.com/g/200/300"
        wikipediaUrl = (try? breed.decode(String.self, forKey: .wikipediaUrl)) ?? ""
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

extension Breed {
    var tableRepresentaion: [BreedData] {
        var tableContent = [(String, String)]()
        tableContent.append(("Name", name))
        tableContent.append(("Description", description))
        tableContent.append(("Life span", lifeSpan))
        tableContent.append(("Indoor", String(indoor)))
        tableContent.append(("Adaptiblity", String(adaptibility)))
        tableContent.append(("Affection Level", String(affectionLivel)))
        tableContent.append(("Child Friendly", String(childFriendly)))
        tableContent.append(("Dog Friendly", String(dogFriendly)))
        tableContent.append(("Enery Level", String(energyLevel)))
        tableContent.append(("Intelligence", String(intelligence)))
        return tableContent
    }
}
