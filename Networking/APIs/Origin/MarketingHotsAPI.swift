//
//  MarketingHotsAPI.swift
//  Networking
//
//  Created by 陸瑋恩 on 2021/11/8.
//

import Foundation

class MarketingHotsAPI {
    
    enum Endpoint: String {
        case hots = "https://api.appworks-school.tw/api/1.0/marketing/hots"
        case campaigns = "https://api.appworks-school.tw/api/1.0/marketing/campaigns"
        
        var url: URL {
            return URL(string: rawValue)!
        }
    }
}
