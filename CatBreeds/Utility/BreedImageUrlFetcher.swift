//
//  BreedImageFetcher.swift
//  CatBreeds
//
//  Created by Yash on 01/12/23.
//
import Foundation

protocol BreedImageUrlFetcherDelegate: AnyObject {
    func success(index: Int, _ breedImage: BreedImage)
    func failure(index: Int, _ error: Error)
}

final class BreedImageUrlFetcher {
    static let shared = BreedImageUrlFetcher()
    private init() {}
    
    var delegates = [BreedImageUrlFetcherDelegate]()
    
    func getImageUrl(index: Int, referenceImageId: String) {
        
        APIManager.shared.makeAPICall(call: .getImageUrl(referenceImageId)) {[weak self] (result: Result<BreedImage, NetworkError>) in
            switch result {
            case .success(let breedImage):
                self?.delegates.forEach{$0.success(index: index, breedImage)}
            case .failure(let error):
                self?.delegates.forEach{$0.failure(index: index, error)}
            }
        }
    }
}
