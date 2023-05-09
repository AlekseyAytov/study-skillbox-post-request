//
//  Service.swift
//  19.5 Practice task
//
//  Created by Alex Aytov on 5/2/23.
//

import UIKit

class Service {
    
    private var urlString = "https://jsonplaceholder.typicode.com/posts"

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
    
    func uploadURLSession(networkModel: NetworkModel, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let uploadData = try? JSONEncoder().encode(networkModel) else { return }
        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            completion(data, response, error)
        }
        task.resume()
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
