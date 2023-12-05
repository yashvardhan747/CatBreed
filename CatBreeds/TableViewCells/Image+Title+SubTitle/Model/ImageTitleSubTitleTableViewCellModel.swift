//
//  ImageTitleSubTitleTableViewCellModel.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//

struct ImageUrlFetchable: Fetchable {
    var urlString: String
}

struct ImageTitleSubTitleTableViewCellModel {
    let title: String
    let value: String
    let imageURLFetchingStatus: FetchingStatus<ImageUrlFetchable>
    
    init(title: String, value: String, imageURLFetchingStatus: FetchingStatus<ImageUrlFetchable>) {
        self.title = title
        self.value = value
        self.imageURLFetchingStatus = imageURLFetchingStatus
    }
}

