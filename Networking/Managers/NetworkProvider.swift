//
//  NetworkProvider.swift
//  Networking
//
//  Created by 陸瑋恩 on 2021/10/27.
//

import Foundation

class NetworkProvider {
    
    enum Error: Swift.Error {
        case notHTTPResponse
        case redirecting
        case clientError
        case serverError
        case unexpectedStatusCode
        
        case selfNotExist
    }
    
    private let urlSession: URLSession = .shared
    
    func fetchObject<Object>(request: URLRequest, type: Object.Type, completion: @escaping (Result<Object, Error>) -> Void) where Object: Decodable {
        fetchData(request: request) { result in
            switch result {
            case let .success(data):
                let object = try! JSONDecoder().decode(Object.self, from: data)
                completion(.success(object))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchData(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        urlSession.dataTask(with: request, completionHandler: { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.notHTTPResponse))
                return
            }
            switch httpResponse.statusCode {
            case 200..<300:
                completion(.success(data!))
            case 300..<400:
                completion(.failure(.redirecting))
            case 400..<500:
                completion(.failure(.clientError))
            case 500..<600:
                completion(.failure(.serverError))
            default:
                completion(.failure(.unexpectedStatusCode))
            }
        }).resume()
    }
}
