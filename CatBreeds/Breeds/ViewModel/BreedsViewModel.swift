//
//  BreedsViewModel.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//
import Foundation

protocol BreedsViewModelDelegate: AnyObject{
    func reloadTableView()
    func showError(message: String)
    func reloadTableView(at index: Int)
}

final class BreedsViewModel {
    weak var delegate: BreedsViewModelDelegate?
    
    private var breeds: [Breed] = []
//    MARK: - Public
    
    init() {
        BreedImageUrlFetcher.shared.delegates.append(self)
    }
    
    var breedCount: Int {
        return breeds.count
    }
    
    func getBreedModel(at index: Int) -> Breed? {
        guard index < breeds.count else {return nil}
        return breeds[index]
    }
    
    func getCellViewModel(at index: Int) -> ImageTitleSubTitleTableViewCellViewModel? {
        guard let breed = getBreedModel(at: index) else {return nil}
    
        var taskProgressStatus: FetchingStatus<ImageUrlFetchable>
        
        switch breed.breedImageURLFetchingStatus {
        case .notStarted:
            fetchImageUrl(index: index)
            taskProgressStatus = .notStarted
        case .fetched(let breedImage):
            taskProgressStatus = .fetched(ImageUrlFetchable(urlString: breedImage.urlString))
        case .failed:
            taskProgressStatus = .failed
        case .fetching:
            taskProgressStatus = .fetching
        }
        
        return ImageTitleSubTitleTableViewCellViewModel(index: index,
                                                        model: ImageTitleSubTitleTableViewCellModel(
                                                        title: breed.name,
                                                        value: breed.id,
                                                        imageURLFetchingStatus: taskProgressStatus))
    }
    
    func getDetailViewModel(at index: Int) -> BreedDetailViewModel? {
        guard index < breeds.count else {return nil}
        let breed = breeds[index]
        let vm = BreedDetailViewModel(index: index, BreedDetailModel(breed))
        BreedImageUrlFetcher.shared.delegates.append(vm)
        return vm
    }
    
    func reloadImageUrl(for index: Int) {
        if var breed = getBreedModel(at: index) {
            breed.breedImageURLFetchingStatus = .notStarted
            breeds[index] = breed
            delegate?.reloadTableView(at: index)
        }
    }
}
//MARK: - API Calling

extension BreedsViewModel {
    func fetchBreeds() {
            APIManager.shared.makeAPICall(call: .getBreeds) {[weak self] (result: Result<[DecodingFailableObject<Breed>], NetworkError>) in
                switch result {
                case .success(let decodingFailableBreeds):
                    
                    self?.breeds = decodingFailableBreeds.compactMap { optionalBreed in
                        switch optionalBreed.value {
                        case .success(let breed):
                            return breed
                        case .failure(_):   // TODO: Can catch decoding error
                            return nil
                        }
                    }
                    self?.delegate?.reloadTableView()
                case .failure(let error):
                    self?.delegate?.showError(message: error.getErrorString)
                }
            }
    }
    
    private func fetchImageUrl(index: Int) {
        guard let breed = getBreedModel(at: index) else {return}
        let referenceImageId = breed.referenceImageId
        breeds[index].breedImageURLFetchingStatus = .fetching
        BreedImageUrlFetcher.shared.getImageUrl(index: index, referenceImageId: referenceImageId)
    }
}
//MARK: - BreedImageUrlFetcherDelegate

extension BreedsViewModel: BreedImageUrlFetcherDelegate {
    func success(index: Int, _ breedImage: BreedImage) {
        if var breed = getBreedModel(at: index) {
            breed.breedImageURLFetchingStatus = .fetched(breedImage)
            breeds[index] = breed
            delegate?.reloadTableView(at: index)
        }
    }
    
    func failure(index: Int, _ error: Error) {
        if var breed = getBreedModel(at: index) {
            breed.breedImageURLFetchingStatus = .failed
            breeds[index] = breed
            delegate?.reloadTableView(at: index)
        }
    }
}
