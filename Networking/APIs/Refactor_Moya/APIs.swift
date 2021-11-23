//
//  APIs.swift
//  Networking_Refactor_Moya
//
//  Created by 陸瑋恩 on 2021/11/23.
//

import Moya
import struct Alamofire.HTTPHeaders

protocol StylishAPIProtocol: TargetType {
    var basePath: String { get }
    var additionalPath: String { get }
    var httpHeaders: HTTPHeaders { get }
    var apiVersion: String { get }
}

extension StylishAPIProtocol {
    
    var baseURL: URL {
        return URL(string: "https://api.appworks-school.tw/api\(apiVersion)")!
    }
    
    var path: String {
        return "\(basePath)\(additionalPath)"
    }
    
    var headers: [String : String]? {
        return httpHeaders.dictionary
    }
    
    var sampleData: Data {
        return Data()
    }
}

// MARK: - MarketingHotsAPI
enum MarketingHotsAPI: StylishAPIProtocol {
    case hots
    case campaigns
    
    var basePath: String {
        return "/marketing"
    }
    
    var additionalPath: String {
        switch self {
        case .hots:
            return "/hots"
        case .campaigns:
            return "/campaigns"
        }
    }
    
    var apiVersion: String {
        switch self {
        case .hots, .campaigns:
            return "/1.0"
        }
    }
    
    var method: Method {
        switch self {
        case .hots, .campaigns:
            return .get
        }
    }
    
    var httpHeaders: HTTPHeaders {
        switch self {
        case .hots, .campaigns:
            return []
        }
    }
    
    var task: Task {
        switch self {
        case .hots, .campaigns:
            return .requestPlain
        }
    }
}

// MARK: - ProductListAPI
enum ProductListAPI: StylishAPIProtocol {
    case all(nextPage: Int?)
    case women(nextPage: Int?)
    case men(nextPage: Int?)
    case accessories(nextPage: Int?)
    case search(keyword: String, nextPage: Int?)
    case details(id: Int)
    
    var basePath: String {
        return "/products"
    }
    
    var additionalPath: String {
        switch self {
        case .all:
            return "/"
        case .women:
            return "/women"
        case .men:
            return "/men"
        case .accessories:
            return "/accessories"
        case .search:
            return "/search"
        case .details:
            return "/details"
        }
    }
    
    var apiVersion: String {
        switch self {
        case .all, .women, .men, .accessories, .search, .details:
            return "/1.0"
        }
    }
    
    var method: Method {
        switch self {
        case .all, .women, .men, .accessories, .search, .details:
            return .get
        }
    }
    
    var httpHeaders: HTTPHeaders {
        switch self {
        case .all, .women, .men, .accessories, .search, .details:
            return []
        }
    }
    
    var task: Task {
        switch self {
        case let .all(nextPage: nextPage), let .women(nextPage: nextPage), let .men(nextPage: nextPage), let .accessories(nextPage: nextPage):
            var parameters: [String: Any] = [:]
            if let nextPage = nextPage {
                parameters["nextPage"] = nextPage
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        case let .search(keyword: keyword, nextPage: nextPage):
            var parameters: [String: Any] = [:]
            parameters["keyword"] = keyword
            if let nextPage = nextPage {
                parameters["nextPage"] = nextPage
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        case let .details(id: id):
            var parameters: [String: Any] = [:]
            parameters["id"] = id
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}

// MARK: - SignInAPI
enum SignInAPI: StylishAPIProtocol {
    case signIn(email: String, password: String)
    case signInWithFacebook(accessToken: String)
    case signUp(email: String, password: String, name: String)
    case profile(accessToken: String)
    
    var basePath: String {
        return "/user"
    }
    
    var additionalPath: String {
        switch self {
        case .signIn, .signInWithFacebook:
            return "/signin"
        case .signUp:
            return "/signUp"
        case .profile:
            return "/profile"
        }
    }
    
    var apiVersion: String {
        switch self {
        case .signIn, .signInWithFacebook, .signUp, .profile:
            return "/1.0"
        }
    }
    
    var method: Method {
        switch self {
        case .signIn, .signInWithFacebook, .signUp:
            return .post
        case .profile:
            return .get
        }
    }
    
    var httpHeaders: HTTPHeaders {
        switch self {
        case .signIn, .signInWithFacebook, .signUp:
            return [
                .contentType("application/json")
            ]
        case let .profile(accessToken: accessToken):
            return [
                .authorization(bearerToken: accessToken)
            ]
        }
    }
    
    var task: Task {
        switch self {
        case let .signIn(email: email, password: password):
            let parameters = [
                "provider": "native",
                "email": email,
                "password": password
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case let .signInWithFacebook(accessToken: accessToken):
            let parameters = [
                "provider": "facebook",
                "access_token": accessToken
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case let .signUp(email: email, password: password, name: name):
            let parameters = [
                "email": email,
                "password": password,
                "name": name
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .profile:
            return .requestPlain
        }
    }
}

// MARK: - CheckOutAPI
enum CheckOutAPI: StylishAPIProtocol {
    case checkout(accessToken: String, checkOutInfo: CheckOutInfo)
    
    var basePath: String {
        return "/order"
    }
    
    var additionalPath: String {
        switch self {
        case .checkout:
            return "/checkout"
        }
    }
    
    var apiVersion: String {
        switch self {
        case .checkout:
            return "/1.0"
        }
    }
    
    var method: Method {
        switch self {
        case .checkout:
            return .post
        }
    }
    
    var httpHeaders: HTTPHeaders {
        switch self {
        case let .checkout(accessToken: accessToken, checkOutInfo: _):
            return [
                .contentType("application/json"),
                .authorization(bearerToken: accessToken)
            ]
        }
    }
    
    var task: Task {
        switch self {
        case let .checkout(accessToken: _, checkOutInfo: checkOutInfo):
            return .requestJSONEncodable(checkOutInfo)
        }
    }
}
