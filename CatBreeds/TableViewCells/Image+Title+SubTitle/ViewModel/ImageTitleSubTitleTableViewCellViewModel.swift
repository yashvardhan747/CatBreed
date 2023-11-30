//
//  ImageTitleSubTitleTableViewCellViewModel.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//
import Foundation

final class ImageTitleSubTitleTableViewCellViewModel {
    private let model: ImageTitleSubTitleTableViewCellModel
    
    private var imageUrlString: String?
    
    init(_ model: ImageTitleSubTitleTableViewCellModel) {
        self.model = model
    }
    
    var getReferenceImageId: String {
        model.referenceImageId
    }
    
    var getTitle: String {
        model.title
    }
    
    var getValue: String {
        model.value
    }
    
}

