//
//  BreedMetaData.swift
//  CatBreeds
//
//  Created by Astrotalk on 01/12/23.
//

struct BreedMetaData {
    let title: String
    let value: String
    
    init(_ title: String, _ value: String) {
        self.title = title
        self.value = value
    }
}

struct BreedDetailModel {
    var breed: Breed
    let tableRepresentation: [BreedMetaData]
    
    init(_ breed: Breed) {
        self.breed = breed
        
        var tableContent = [BreedMetaData]()
        tableContent.append(BreedMetaData("Name", breed.name))
        if let description = breed.description {tableContent.append(BreedMetaData("Description", description))}
        if let lifeSpan = breed.lifeSpan {tableContent.append(BreedMetaData("Life span", lifeSpan))}
        if let indoor = breed.indoor {tableContent.append(BreedMetaData("Indoor", String(indoor)))}
        if let adaptibility = breed.adaptibility {tableContent.append(BreedMetaData("Adaptiblity", String(adaptibility)))}
        if let affectionLivel = breed.affectionLivel {tableContent.append(BreedMetaData("Affection Level", String(affectionLivel)))}
        if let childFriendly = breed.childFriendly {tableContent.append(BreedMetaData("Child Friendly", String(childFriendly)))}
        if let dogFriendly = breed.dogFriendly {tableContent.append(BreedMetaData("Dog Friendly", String(dogFriendly)))}
        if let energyLevel = breed.energyLevel {tableContent.append(BreedMetaData("Entry Level", String(energyLevel)))}
        if let intelligence = breed.intelligence {tableContent.append(BreedMetaData("Intelligence", String(intelligence)))}
        
        tableRepresentation = tableContent
    }
}
