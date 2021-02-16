//
//  APIRequest.swift
//  Habits
//
//  Created by 鈴木ちほり on 2021/02/15.
//

import Foundation

protocol APIRequest {
    associatedtype Response
    
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var request: URLRequest { get }
    var postData: Data? { get }
    
}

extension APIRequest {
    var host: String { "localhost" }
    var port: Int { 8080 }
}

extension APIRequest {
    var queryItems: [URLQueryItem]? { nil }
    var postData: Data? { nil }
}

extension APIRequest {
    var request: URLRequest {
        var components = URLComponents()

        components.scheme = "http"
        components.host = host
        components.port = port
        components.path = path
        components.queryItems = queryItems

        var request = URLRequest(url: components.url!)

        if let data = postData {
            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
        }
        return request
    }
}

extension APIRequest where Response: Decodable {
    func send(completion: @escaping (Result<Response, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            do {
                print("before data")
                if let data = data {
                    print(data)
                    print("before decoded")
                    let decoded = try JSONDecoder().decode(Response.self, from: data)
                    print("before success")
                    completion(.success(decoded))
                } else if let error = error {
                    completion(.failure(error))
                }
            } catch {
                print("catch")
            }
        }.resume()
    }
}
