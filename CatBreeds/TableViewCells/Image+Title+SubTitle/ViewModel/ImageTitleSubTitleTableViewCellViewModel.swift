//
//  ImageTitleSubTitleTableViewCellViewModel.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//

struct ImageTitleSubTitleTableViewCellViewModel {
    private let model: ImageTitleSubTitleTableViewCellModel
    let index: Int
    
    init(index: Int, model: ImageTitleSubTitleTableViewCellModel) {
        self.index = index
        self.model = model
    }
    
    var imageURLFetchingStatus: FetchingStatus<ImageUrlFetchable> {
        model.imageURLFetchingStatus
    }
    
    var getTitle: String {
        model.title
    }
    
    var getValue: String {
        model.value
    }
    
}

