//
//  BreedDetailViewModel.swift
//  CatBreeds
//
//  Created by Astrotalk on 29/11/23.
//

final class BreedDetailViewModel {
    private let breed: Breed
    
    init(_ model: Breed) {
        self.breed = model
    }
    
    var imageUrlString: String {
        return breed.imageUrl
    }
    
    var name: String {
        breed.name
    }
    
    var id: String {
        breed.id
    }
    var tableRepresentaionCount: Int {
        breed.tableRepresentaion.count
    }
    
    func getBreedMetaData(at index: Int) -> BreedData {
        breed.tableRepresentaion[index]
    }
}

