//
//  Extensions.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//
import UIKit
//MARK: - UIImageView
extension UIImageView {
    
    func setAndSaveImage(imageUrlString: String?, imageName: String, handler: @escaping (Bool) -> Void){
        if let data: Data = PersistencyManager.shared.getFromCache(filename: imageName.removeWhiteSpaces()), let image = UIImage(data: data) {
            self.image = image
            handler(true)
            return
        }

        guard let imageUrlString = imageUrlString else {
            handler(false)
            return
        }
        
        DispatchQueue.global(qos: .userInteractive).async {[weak self] in
            guard let aUrl = URL(string: imageUrlString) else {return}
            if let data = try? Data(contentsOf: aUrl), let image = UIImage(data: data) {
                PersistencyManager.shared.saveInCache(image.pngData(), filename: imageName.removeWhiteSpaces())
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
//MARK: - String
extension String {
    func removeWhiteSpaces() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
}

//MARK: - UIStoryboard
extension UIStoryboard {
    static var breedsStoryBoard: UIStoryboard {
        UIStoryboard(name: Constants.StoryBoardIdentifiers.BreedScreens.identifier, bundle: nil)
    }
}
//MARK: - URLSession
extension URLSession {
    
    func dataTask(with request: URLRequest, resultHandler: @escaping (Result<Data, NetworkError>) -> Void) -> URLSessionDataTask {
        
        return self.dataTask(with: request) { data, response, error in
            
            if let networkError = NetworkError(data: data, response: response, error: error) {
                resultHandler(.failure(networkError))
                return
            }
            
            resultHandler(.success(data!))
        }
    }
}
