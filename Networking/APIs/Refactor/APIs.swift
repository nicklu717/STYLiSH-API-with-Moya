//
//  APIs.swift
//  Networking_Refactor
//
//  Created by 陸瑋恩 on 2021/11/20.
//

import Foundation

protocol StylishAPIProtocol {
    var host: String { get }
    var basePath: String { get }
    var additionalPath: String { get }
    var url: URL { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    
    func makeRequest() -> URLRequest
}

extension StylishAPIProtocol {
    
    var host: String {
        return "https://api.appworks-school.tw/api/1.0"
    }
    
    var url: URL {
        return URL(string: "\(host)\(basePath)\(additionalPath)")!
    }
    
    func makeRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        return request
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
    
    var method: String {
        switch self {
        case .hots, .campaigns:
            return "GET"
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .hots, .campaigns:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .hots, .campaigns:
            return nil
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
        case let .all(nextPage: nextPage):
            var path = "/"
            if let nextPage = nextPage {
                path += "?paging=\(nextPage)"
            }
            return path
        case let .women(nextPage: nextPage):
            var path = "/women"
            if let nextPage = nextPage {
                path += "?paging=\(nextPage)"
            }
            return path
        case let .men(nextPage: nextPage):
            var path = "/men"
            if let nextPage = nextPage {
                path += "?paging=\(nextPage)"
            }
            return path
        case let .accessories(nextPage: nextPage):
            var path = "/accessories"
            if let nextPage = nextPage {
                path += "?paging=\(nextPage)"
            }
            return path
        case let .search(keyword: keyword, nextPage: nextPage):
            var path = "/search?keyword=\(keyword)"
            if let nextPage = nextPage {
                path += "&paging=\(nextPage)"
            }
            return path
        case let .details(id: id):
            return "/details?id=\(id)"
        }
    }
    
    var method: String {
        switch self {
        case .all, .women, .men, .accessories, .search, .details:
            return "GET"
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .all, .women, .men, .accessories, .search, .details:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .all, .women, .men, .accessories, .search, .details:
            return nil
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
    
    var method: String {
        switch self {
        case .signIn, .signInWithFacebook, .signUp:
            return "POST"
        case .profile:
            return "GET"
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .signIn, .signInWithFacebook, .signUp:
            return ["Content-Type": "application/json"]
        case let .profile(accessToken: accessToken):
            return ["Authorization": "Bearer \(accessToken)"]
        }
    }
    
    var body: Data? {
        switch self {
        case let .signIn(email: email, password: password):
            let parameters = [
                "provider": "native",
                "email": email,
                "password": password
            ]
            return try! JSONEncoder().encode(parameters)
            
        case let .signInWithFacebook(accessToken: accessToken):
            let parameters = [
                "provider": "facebook",
                "access_token": accessToken
            ]
            return try! JSONEncoder().encode(parameters)
            
        case let .signUp(email: email, password: password, name: name):
            let parameters = [
                "email": email,
                "password": password,
                "name": name
            ]
            return try! JSONEncoder().encode(parameters)
            
        case .profile:
            return nil
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
    
    var method: String {
        switch self {
        case .checkout:
            return "POST"
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case let .checkout(accessToken: accessToken, checkOutInfo: _):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(accessToken)"
            ]
        }
    }
    
    var body: Data? {
        switch self {
        case let .checkout(accessToken: _, checkOutInfo: checkOutInfo):
            return try! JSONEncoder().encode(checkOutInfo)
        }
    }
}
