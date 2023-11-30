//
//  BreedDetailViewModel.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//
import Foundation

typealias BreedData = (title: String, value: String)

final class BreedDetailViewModel {
    private let breed: Breed
    private let tableRepresentaion: [BreedData]
    
    init(_ model: Breed) {
        self.breed = model
        
        var tableContent = [(String, String)]()
        tableContent.append(("Name", breed.name))
        tableContent.append(("Description", breed.description))
        tableContent.append(("Life span", breed.lifeSpan))
        tableContent.append(("Indoor", String(breed.indoor)))
        tableContent.append(("Adaptiblity", String(breed.adaptibility)))
        tableContent.append(("Affection Level", String(breed.affectionLivel)))
        tableContent.append(("Child Friendly", String(breed.childFriendly)))
        tableContent.append(("Dog Friendly", String(breed.dogFriendly)))
        tableContent.append(("Enery Level", String(breed.energyLevel)))
        tableContent.append(("Intelligence", String(breed.intelligence)))
        
        tableRepresentaion = tableContent
    }
    
    var referenceImageId: String {
        return breed.referenceImageId
    }
    
    var name: String {
        breed.name
    }
    
    var id: String {
        breed.id
    }
    
    var isImageUrlPresent: Bool {
        if let _ = UserDefaults.standard.string(forKey: breed.referenceImageId) {
            return true
        }
        return false
    }
    
    var tableRepresentaionCount: Int {
        tableRepresentaion.count
    }
    
    func getBreedMetaData(at index: Int) -> BreedData {
        tableRepresentaion[index]
    }
    
}

