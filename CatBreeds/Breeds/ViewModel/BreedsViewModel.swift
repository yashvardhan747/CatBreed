//
//  BreedsViewModel.swift
//  CatBreeds
//
//  Created by Astrotalk on 29/11/23.
//

protocol BreedsViewModelDelegate: AnyObject {
    func reloadTableView()
    func showError(message: String)
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
    
    func getCellViewModel(at index: Int) -> Image_Title_SubTitleTableViewCellViewModel? {
        guard index < breeds.count else {return nil}
        let breed = breeds[index]
        return Image_Title_SubTitleTableViewCellViewModel(Image_Title_SubTitleTableViewCellModel(imageUrl: breed.imageUrl, title: breed.id, value: breed.name))
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
                self?.delegate?.reloadTableView()
            case .failure(let error):
                self?.delegate?.showError(message: error.localizedDescription)
            }
        }
      }
}

