//
//  CheckOutAPI.swift
//  Networking
//
//  Created by 陸瑋恩 on 2021/11/8.
//

import Foundation

class CheckOutAPI {
    
    enum Endpoint: String {
        case checkout = "https://api.appworks-school.tw/api/1.0/order/checkout"
        
        var url: URL {
            return URL(string: rawValue)!
        }
    }
}
