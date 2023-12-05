//
//  BreedDetailViewModel.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//
import Foundation

protocol BreedDetailViewModelDelegate: AnyObject {
    func reloadImageView()
}

final class BreedDetailViewModel {
    private var breedDetailModel: BreedDetailModel
    let index: Int
    
    weak var delegate: BreedDetailViewModelDelegate?
    
    init(index: Int, _ model: BreedDetailModel) {
        self.index = index
        self.breedDetailModel = model
    }
    
    var name: String {
        breedDetailModel.breed.name
    }
    
    var tableRepresentaionCount: Int {
        breedDetailModel.tableRepresentation.count
    }
    
    var imageURLFetchingStatus: FetchingStatus<BreedImage> {
        breedDetailModel.breed.breedImageURLFetchingStatus
    }
    
    func getBreedMetaData(at index: Int) -> BreedMetaData {
        breedDetailModel.tableRepresentation[index]
    }
    
    func fetchImageUrl() {
        let refId = breedDetailModel.breed.referenceImageId
        BreedImageUrlFetcher.shared.getImageUrl(index: index, referenceImageId: refId)
    }
    
}


extension BreedDetailViewModel: BreedImageUrlFetcherDelegate {
    func success(index: Int, _ breedImage: BreedImage) {
        guard self.index == index else {return}
        
        breedDetailModel.breed.breedImageURLFetchingStatus = .fetched(breedImage)
        delegate?.reloadImageView()
    }
    
    func failure(index: Int, _ error: Error) {
        breedDetailModel.breed.breedImageURLFetchingStatus = .failed
        delegate?.reloadImageView()
    }
    
}
