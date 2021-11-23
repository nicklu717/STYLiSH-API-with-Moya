//
//  SignInManager.swift
//  Networking_Origin
//
//  Created by 陸瑋恩 on 2021/11/23.
//

import Moya

class SignInManager {
    
    private let networkProvider = NetworkProvider()
    
    func signIn(email: String, password: String, completion: @escaping (Result<SignInResponse, Error>) -> Void) {
        #if ORIGIN
        let parameters = [
            "provider": "native",
            "email": email,
            "password": password
        ]
        var request = URLRequest(url: SignInAPI.Endpoint.signIn.url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
        request.httpBody = try! JSONEncoder().encode(parameters)
        
        networkProvider.fetchObject(request: request, type: SignInResponse.self) { result in
            switch result {
            case let .success(response):
                completion(.success(response))
            case let .failure(error):
                completion(.failure(error))
            }
        }
        #elseif REFACTOR
        networkProvider.fetchObject(api: SignInAPI.signIn(email: email, password: password), type: SignInResponse.self) { result in
            switch result {
            case let .success(response):
                completion(.success(response))
            case let .failure(error):
                completion(.failure(error))
            }
        }
        #elseif REFACTOR_MOYA
        let moyaProvider = MoyaProvider<SignInAPI>()
        moyaProvider.requestObject(.signIn(email: email, password: password), type: SignInResponse.self) { result in
            switch result {
            case let .success(response):
                completion(.success(response))
            case let .failure(error):
                completion(.failure(error))
            }
        }
        #endif
    }
}
