//
//  MoyaNetworkProvider.swift
//  Networking_Refactor_Moya
//
//  Created by 陸瑋恩 on 2021/11/23.
//

import Moya

class MoyaNetworkProvider<StylishAPI: TargetType> {
    
    private let moyaProvider = MoyaProvider<StylishAPI>()
    
    func fetchObject<Object>(api: StylishAPI, type: Object.Type, completion: @escaping (Result<Object, Error>) -> Void) where Object: Decodable {
        fetchData(api: api) { result in
            switch result {
            case let .success(data):
                completion(.success(try! JSONDecoder().decode(type.self, from: data)))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchData(api: StylishAPI, completion: @escaping (Result<Data, Error>) -> Void) {
        moyaProvider.request(api) { result in
            switch result {
            case let .success(response):
                completion(.success(response.data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
