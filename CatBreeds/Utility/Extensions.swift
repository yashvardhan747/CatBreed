//
//  Extensions.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//
import UIKit

extension UIImageView {
    
    func setAndSaveImage(imageUrlString: String?, imageName: String, handler: @escaping (Bool) -> Void){
        if let data: Data = PersistencyManager.shared.getFromCache(filename: imageName), let image = UIImage(data: data) {
            self.image = image
            handler(true)
            return
        }

        guard let imageUrlString = imageUrlString else {
//        guard let imageUrlString = UserDefaults.standard.string(forKey: referenceImageId) else {
            handler(false)
            return
        }
        
        DispatchQueue.global(qos: .userInteractive).async {[weak self] in
            guard let aUrl = URL(string: imageUrlString) else {return}
            if let data = try? Data(contentsOf: aUrl), let image = UIImage(data: data) {
                PersistencyManager.shared.saveInCache(image.pngData(), filename: imageName)
                DispatchQueue.main.async {
                    self?.image = image
                    handler(true)
                }
            }else {
                DispatchQueue.main.async {
                    handler(false)
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

