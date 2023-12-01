//
//  ImageTitleSubTitleTableViewCellModel.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//

struct ImageUrlFetchable: Fetchable {
    var urlString: String?
}

struct ImageTitleSubTitleTableViewCellModel {
    let title: String
    let value: String
    let imageFetchingStatus: FetchingStatus<ImageUrlFetchable>
    
    init(title: String, value: String, imageFetchingStatus: FetchingStatus<ImageUrlFetchable>) {
        self.title = title
        self.value = value
        self.imageFetchingStatus = imageFetchingStatus
    }
}

