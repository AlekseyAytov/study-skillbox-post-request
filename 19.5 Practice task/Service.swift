//
//  Service.swift
//  19.5 Practice task
//
//  Created by Alex Aytov on 5/2/23.
//

import UIKit
import Alamofire

class Service {
    
    static let shared = Service()
    
    private init() {
    }
    
    private var urlString = "https://jsonplaceholder.typicode.com/posts"

    enum NetworkError: Error {
        case badURL, badRequest, badResponse, encodeError
    }
    
    func sendURLSession(networkModel: NetworkModel, completion: @escaping (String?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, nil, NetworkError.badURL)
            return
        }

        guard let uploadData = try? JSONEncoder().encode(networkModel) else {
            completion(nil, nil, NetworkError.encodeError)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                completion(nil, nil, error)
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                completion(nil, response, nil)
                return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                completion(dataString, nil, nil)
            }
        }
        task.resume()
    }
    
    func sendURLSessionWithResult(networkModel: NetworkModel, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            return completion(.failure(NetworkError.badURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let uploadData = try? JSONEncoder().encode(networkModel) else {
            return completion(.failure(NetworkError.encodeError))
        }
        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                completion(.failure(NetworkError.badResponse))
                return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                completion(.success(dataString))
            }
        }
        task.resume()
    }
    
    func sendAlamofire(networkModel: NetworkModel, completion: @escaping (Result<String, Error>) -> Void) {
        AF.request(urlString, method: .post, parameters: networkModel).validate().response { response in
            
            if let error = response.error {
                completion(.failure(error))
                return
            }
            
            guard let resp = response.response,
                (200...299).contains(resp.statusCode) else {
                completion(.failure(NetworkError.badResponse))
                return
            }
            
            if let data = response.data, let dataString = String(data: data, encoding: .utf8) {
                completion(.success(dataString))
            }
        }
    }
    
    
    
    
    
    
    
    
    
    // сервис загрузки картинки по url
    func loadImageAsync(urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let contentOfURL = try? Data(contentsOf: url) else {
                print("Ошибка, не удалось загрузить изображение")
                completion(nil)
                return
            }
            completion(contentOfURL)
        }
    }

    // сервис API запроса
    func getSearchResults(searchExpression: String?, completion: @escaping (Data?, Error?) -> Void) {
        guard let searchExpression = searchExpression,
              let url = URL(string: urlString + searchExpression) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            completion(data, nil)
        }
        
        print("Запрос с параметром - \(searchExpression)")
        task.resume()
    }

//    // сервис декодирования JSON в network model
//    func parseDecoder(data: Data) -> SearchResults? {
//        guard let decode = try? JSONDecoder().decode(SearchResults.self, from: data) else {
//            print("Ошибка декодирования - \(data)")
//            return nil
//        }
//        return decode
//    }
}
