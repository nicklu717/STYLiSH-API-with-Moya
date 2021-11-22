//
//  APIs.swift
//  Networking_Refactor
//
//  Created by 陸瑋恩 on 2021/11/20.
//

import Foundation

// MARK: - MarketingHotsAPI
class MarketingHotsAPI {
    
    enum Endpoint: String {
        case hots = "https://api.appworks-school.tw/api/1.0/marketing/hots"
        case campaigns = "https://api.appworks-school.tw/api/1.0/marketing/campaigns"
        
        var url: URL {
            return URL(string: rawValue)!
        }
    }
}

struct MarketingHots: Codable {
    let data: [Hots]
}

// MARK: - ProductListAPI
class ProductListAPI {
    
    enum Endpoint: String {
        case all = "https://api.appworks-school.tw/api/1.0/products/"
        case women = "https://api.appworks-school.tw/api/1.0/products/women"
        case men = "https://api.appworks-school.tw/api/1.0/products/men"
        case accessories = "https://api.appworks-school.tw/api/1.0/products/accessories"
        case search = "https://api.appworks-school.tw/api/1.0/products/search"
        case details = "https://api.appworks-school.tw/api/1.0/products/details"
        
        var url: URL {
            return URL(string: rawValue)!
        }
    }
}

struct ProductList: Codable {
    var data: [Product]
}

// MARK: - SignInAPI
class SignInAPI {
    
    enum Endpoint: String {
        case signIn = "https://api.appworks-school.tw/api/1.0/user/signin"
//        case signInWithFacebook = "https://api.appworks-school.tw/api/1.0/user/signin"
        case signUp = "https://api.appworks-school.tw/api/1.0/user/signUp"
        case profile = "https://api.appworks-school.tw/api/1.0/user/profile"
        
        var url: URL {
            return URL(string: rawValue)!
        }
    }
}

struct SignInInfo: Codable {
    let provider: String
    let accessToken: String
}

struct SignInResponse: Codable {
    let data: SignInResponseContent
}

struct SignInResponseContent: Codable {
    let accessToken: String
    let accessExpired: Int
    let user: User
}

// MARK: - CheckOutAPI
class CheckOutAPI {
    
    enum Endpoint: String {
        case checkout = "https://api.appworks-school.tw/api/1.0/order/checkout"
        
        var url: URL {
            return URL(string: rawValue)!
        }
    }
}

struct CheckOutInfo: Codable {
    var prime: String
    let order: Order
}

struct Order: Codable {
    let shipping: String
    let payment: String
    let subtotal: Int
    let freight: Int
    let total: Int
    let recipient: Recipient
    let list: [OrderedProduct]
}

struct Recipient: Codable {
    let name: String
    let phone: String
    let email: String
    let address: String
    let time: String
}

struct OrderedProduct: Codable {
    let id: String
    let name: String
    let price: Int16
    let color: Color
    let size: String
    let qty: Int16
}
