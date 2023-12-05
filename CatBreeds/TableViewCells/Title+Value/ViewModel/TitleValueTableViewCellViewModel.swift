//
//  TitleValueTableViewCellViewModel.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//

struct TitleValueTableViewCellViewModel {
    private let model: TitleValueTableViewCellModel
    
    init(_ model: TitleValueTableViewCellModel) {
        self.model = model
    }
    
    var dataTitle: String {
        model.title
    }
    
    var dataValue: String {
        model.value
    }
}
