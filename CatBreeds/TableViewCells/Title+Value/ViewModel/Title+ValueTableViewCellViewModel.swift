//
//  Title+ValueTableViewCellViewModel.swift
//  CatBreeds
//
//  Created by Astrotalk on 29/11/23.
//

final class Title_ValueTableViewCellViewModel {
    private let model: Title_ValueTableViewCellModel
    
    init(_ model: Title_ValueTableViewCellModel) {
        self.model = model
    }
    
    var dataTitle: String {
        model.title
    }
    
    var dataValue: String {
        model.value
    }
}
