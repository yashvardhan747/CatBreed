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
    func reloadImageView(at index: Int)
}

final class BreedsViewModel {
    weak var delegate: BreedsViewModelDelegate?
    
    private var breeds: [Breed] = []
//    MARK: - Public
    
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
        return ImageTitleSubTitleTableViewCellViewModel(ImageTitleSubTitleTableViewCellModel(title: breed.name,
                                                                                             value: breed.id,
                                                                                             referenceImageId: breed.referenceImageId))
    }
    
    func getDetailViewModel(at index: Int) -> BreedDetailViewModel? {
        guard index < breeds.count else {return nil}
        let breed = breeds[index]
        return BreedDetailViewModel(breed)
    }
}

extension BreedsViewModel {
    func getBreeds() {
            APIManager.shared.makeAPICall(call: .getBreeds) {[weak self] (result: Result<[Breed]>) in
                switch result {
                case .success(let breeds):
                    self?.breeds = breeds
                    for (i, breed) in breeds.enumerated() {
                        self?.getImageUrl(of: breed.referenceImageId, index: i)
                    }
                    DispatchQueue.main.async {
                        self?.delegate?.reloadTableView()
                    }
                case .failure(let error):
                    self?.delegate?.showError(message: error.localizedDescription)
                }
            }
    }
    
    private func getImageUrl(of referenceImageId: String, index: Int) {
        if let _ = UserDefaults.standard.string(forKey: referenceImageId){
            return
        }
        
        APIManager.shared.makeAPICall(call: .getImageUrl(referenceImageId)) {[weak self] (result: Result<BreedImage>) in
            switch result {
            case .success(let breedImage):
                UserDefaults.standard.setValue(breedImage.imageUrl, forKey: breedImage.referenceImageId)
                DispatchQueue.main.async {
                    self?.delegate?.reloadImageView(at: index)
                }
            case .failure(_):
                break
            }
        }
    }
}
