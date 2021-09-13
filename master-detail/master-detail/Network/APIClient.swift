//
//  APIClient.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 13/09/2021.
//

import Foundation
import Network

class APIClient {
    private let BASE_URL = "https://jsonplaceholder.typicode.com"
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")
    var isNetworkAvailable = true
    
    init() {
        initMonitor()
    }
    
    deinit {
        monitor.cancel()
    }
    
    private func initMonitor() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.isNetworkAvailable = true
           } else {
                self.isNetworkAvailable = false
           }
        }
        monitor.start(queue: queue)
    }
    
    func fetch<T: Codable>(with httpMethod: HTTPMethod, path: String, body: Data?, params: [String: Any] = [:], completion: @escaping (Result<T, Error>) -> Void) {
        var requestParams = "?"
        for (index, item) in params.enumerated() {
            requestParams.append("\(item.key)=\(item.value)")
            if index < params.count {
                requestParams.append("&")
            }
        }
        
        let url = URL(string: "\(BASE_URL)\(path)\(requestParams)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        if let safeBody = body {
            request.httpBody = safeBody
        }
        
        if httpMethod != .get {
            request.allHTTPHeaderFields = ["Content-type": "application/json; charset=UTF-8"]
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let responseData = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: responseData, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
            
            do {
                let responseObject = try JSONDecoder().decode(T.self, from: responseData)
                completion(.success(responseObject))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    func generateBody<T: Codable>(from object: T) -> Data? {
        return try? JSONEncoder().encode(object)
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}
