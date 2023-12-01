//
//  BreedsViewModel.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//
import Foundation

protocol BreedsViewModelDelegate: AnyObject {
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
        guard index < breeds.count else {return nil}
        let breed = breeds[index]
    
        var taskProgressStatus: FetchingStatus<ImageUrlFetchable>
        
        switch breed.breedImageFetchingStatus {
        case .notStarted:
            getImageUrl(index: index)
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
                                                        imageFetchingStatus: taskProgressStatus))
    }
    
    func getDetailViewModel(at index: Int) -> BreedDetailViewModel? {
        guard index < breeds.count else {return nil}
        let breed = breeds[index]
        return BreedDetailViewModel(index: index, BreedDetailModel(breed))
    }
}

extension BreedsViewModel {
    func getBreeds() {
            APIManager.shared.makeAPICall(call: .getBreeds) {[weak self] (result: Result<[Breed]>) in
                switch result {
                case .success(let breeds):
                    self?.breeds = breeds
                    print(breeds)
                    self?.delegate?.reloadTableView()
                case .failure(let error):
                    self?.delegate?.showError(message: error.localizedDescription)
                }
            }
    }
    
    func getImageUrl(index: Int) {
        guard let breed = getBreedModel(at: index), let referenceImageId = breed.referenceImageId else {return}
    
        breeds[index].breedImageFetchingStatus = .fetching
        BreedImageUrlFetcher.shared.getImageUrl(index: index, referenceImageId: referenceImageId)
    }
}

extension BreedsViewModel: BreedImageUrlFetcherDelegate {
    
    func success(index: Int, _ breedImage: BreedImage) {
        breeds[index].breedImageFetchingStatus = .fetched(breedImage)
        delegate?.reloadTableView(at: index)
    }
    
    func failure(index: Int, _ error: Error) {
        
    }
    
}
