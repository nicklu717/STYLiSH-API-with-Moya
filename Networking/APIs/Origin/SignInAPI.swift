//
//  SignInAPI.swift
//  Networking
//
//  Created by 陸瑋恩 on 2021/11/8.
//

import Foundation

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
