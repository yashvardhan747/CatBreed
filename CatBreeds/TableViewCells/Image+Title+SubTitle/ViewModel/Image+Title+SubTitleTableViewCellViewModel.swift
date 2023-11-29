//
//  Image+Title+SubTitleTableViewCellViewModel.swift
//  CatBreeds
//
//  Created by Astrotalk on 29/11/23.
//

final class Image_Title_SubTitleTableViewCellViewModel {
    private let model: Image_Title_SubTitleTableViewCellModel
    
    init(_ model: Image_Title_SubTitleTableViewCellModel) {
        self.model = model
    }
    
    var getImageUrl: String {
        model.imageUrl
    }
    
    var getTitle: String {
        model.title
    }
    
    var getValue: String {
        model.value
    }
    
}

