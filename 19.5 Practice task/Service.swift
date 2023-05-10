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
    
    func sendURLSession(networkModel: NetworkModel, completion: @escaping (String?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, NetworkError.badURL)
            return
        }

        guard let uploadData = try? JSONEncoder().encode(networkModel) else {
            completion(nil, NetworkError.encodeError)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, _, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                completion(dataString, nil)
            }
        }
        task.resume()
    }
    // метод с использованием типа Result
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
        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
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
            
            if let data = response.data, let dataString = String(data: data, encoding: .utf8) {
                completion(.success(dataString))
            }
        }
    }
}
