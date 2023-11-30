//
//  APIManager.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//
import Foundation

final class APIManager {
    static let shared = APIManager()
    private init(){}
    
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
        
        fileprivate func asURLRequest() -> URLRequest? {
            var urlString = getBaseUrl + path
            
            var parameters = [String : String]()
            
            switch self {
            case .getBreeds:
                parameters = [:]
            case .getImageUrl(_):
                parameters = [:]
            }
            
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
    
    
    func makeAPICall<T: Decodable>(call: APICall, onCompletion: @escaping (Result<T>) -> Void){
         guard let request = call.asURLRequest() else {
            onCompletion(.failure(.invalidRequest))
            return
        }
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                onCompletion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else {
                onCompletion(.failure(.invalidResponse))
                return
            }
            
            if let data = try? JSONDecoder().decode(T.self, from: data) {
                onCompletion(.success(data))}
            else {
                onCompletion(.failure(.message(error)))
            }
        }
        
        session.resume()
       
    }
}

