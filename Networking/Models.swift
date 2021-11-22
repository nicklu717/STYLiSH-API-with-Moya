//
//  Models.swift
//  Networking
//
//  Created by 陸瑋恩 on 2021/11/8.
//

struct MarketingHots: Codable {
    let data: [Hots]
}

struct ProductList: Codable {
    var data: [Product]
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

struct Product: Codable {
    let id: Int
    let category: String
    let title: String
    let description: String
    let price: Int
    let texture: String
    let wash: String
    let place: String
    let note: String
    let story: String
    let colors: [Color]
    let sizes: [String]
    let variants: [Variant]
    let mainImage: String
    let images: [String]
}

struct Color: Codable {
    let code: String
    let name: String
}

struct Variant: Codable {
    let colorCode: String
    let size: String
    let stock: Int
}

struct Campaign: Codable {
    let productID: Int
    let picture: String
    let story: String
}

struct Hots: Codable {
    let title: String
    let products: [Product]
}

struct User: Codable {
    let id: Int
    let provider: String
    let name: String
    let email: String
    let picture: String
}
