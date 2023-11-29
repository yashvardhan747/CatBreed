//
//  Image+Title+SubTitleTableViewCellModel.swift
//  CatBreeds
//
//  Created by Astrotalk on 29/11/23.
//
final class Image_Title_SubTitleTableViewCellModel {
    let imageUrl: String
    let title: String
    let value: String
    
    init(imageUrl: String, title: String, value: String) {
        self.imageUrl = imageUrl
        self.title = title
        self.value = value
    }
}

