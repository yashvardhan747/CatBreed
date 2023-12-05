//
//  APIManager.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//
import Foundation

enum APICall {
    
    case getBreeds
    case getImageUrl(String)
    
    private enum BaseURL {
        case dev
        case prod
        
        var getBaseUrl: String {
            switch self {
            case .dev:
                "https://api.thecatapi.com"
            case .prod:
                "https://api.thecatapi.com"
            }
        }
    }
    
    private enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    private var getBaseUrl: String {
        switch self {
        case .getBreeds:
            return BaseURL.prod.getBaseUrl
        case .getImageUrl:
            return BaseURL.prod.getBaseUrl
        }
    }
    
    private var path: String {
        switch self {
        case .getBreeds:
            return "/v1/breeds"
        case .getImageUrl(let refernceId):
            return "/v1/images/\(refernceId)"
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getBreeds:
            return .get
        case .getImageUrl(_):
            return .get
        }
    }
    
    private var parameters: [String : String] {
        switch self {
        case .getBreeds:
            return [:]
        case .getImageUrl(_):
            return [:]
        }
    }
    
    fileprivate func asURLRequest() -> URLRequest? {
        var urlString = getBaseUrl + path
        
        if parameters.isEmpty == false {
            urlString += "/?"
            for (key, value) in parameters {
                urlString += "\(key)=\(value)"
            }
        }
        
        guard let url = URL(string: urlString) else {return nil}
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
}

final class APIManager {
    static let shared = APIManager()
    private init(){}
    
    func makeAPICall<T: Decodable>(call: APICall, completion: @escaping (Result<T, NetworkError>) -> Void){
        guard let request = call.asURLRequest() else {
            completion(.failure(.invalidRequest))
            return
        }
        
        let session = URLSession.shared.dataTask(with: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedData))
                    }catch {
                        completion(.failure(.decodingError(error)))
                    }
                }
            }
            
        }
        
        session.resume()
    }
}
