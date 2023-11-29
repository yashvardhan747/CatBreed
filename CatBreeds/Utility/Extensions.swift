//
//  Extensions.swift
//  CatBreeds
//
//  Created by Astrotalk on 29/11/23.
//
import UIKit

extension UIImageView {
    func setAndSaveImage(urlString: String, name: String) {
        if let data: Data = PersistencyManager.shared.getFromCache(filename: name), let image = UIImage(data: data) {
            self.image = image
            return
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            guard let aUrl = URL(string: urlString) else {return}
            guard let data = try? Data(contentsOf: aUrl),
                  let image = UIImage(data: data) else {
                return
            }
            PersistencyManager.shared.saveInCache(image.pngData(), filename: name)
            DispatchQueue.main.async {
                self.image = image
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

