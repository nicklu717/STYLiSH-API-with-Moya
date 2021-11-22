//
//  ProductListAPI.swift
//  Networking
//
//  Created by 陸瑋恩 on 2021/11/8.
//

import Foundation

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
