//
//  ImageTitleSubTitleTableViewCellModel.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//

final class ImageTitleSubTitleTableViewCellModel {
    let referenceImageId: String
    let title: String
    let value: String
    
    init(title: String, value: String, referenceImageId: String) {
        self.referenceImageId = referenceImageId
        self.title = title
        self.value = value
    }
}

