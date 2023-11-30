//
//  Extensions.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//
import UIKit

extension UIImageView {
    func setAndSaveImage(referenceImageId: String) {
        if let data: Data = PersistencyManager.shared.getFromCache(filename: referenceImageId), let image = UIImage(data: data) {
            self.image = image
            return
        }

        guard let imageUrlString = UserDefaults.standard.string(forKey: referenceImageId) else {
            DispatchQueue.main.async {
                self.image = UIImage(named: Constants.ImageTitle.placeholderCat)
            }
            return
        }
        DispatchQueue.global(qos: .userInteractive).async {
            guard let aUrl = URL(string: imageUrlString) else {return}
            if let data = try? Data(contentsOf: aUrl), let image = UIImage(data: data) {
                PersistencyManager.shared.saveInCache(image.pngData(), filename: referenceImageId)
                DispatchQueue.main.async {
                    self.image = image
                }
            }else {
                DispatchQueue.main.async {
                    self.image = UIImage(named: Constants.ImageTitle.placeholderCat)
                }
            }
        }
    }
}

extension String {
    func removeReduntantSubstring() -> String {
        return self.replacingOccurrences(of: "<p>", with: "").replacingOccurrences(of: "</p>", with: "").replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
    }
}

extension UIStoryboard {
    static var breedsStoryBoard: UIStoryboard {
        UIStoryboard(name: Constants.StoryBoardIdentifiers.BreedScreens.identifier, bundle: nil)
    }
}

