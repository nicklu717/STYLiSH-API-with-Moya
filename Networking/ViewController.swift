//
//  ViewController.swift
//  Networking
//
//  Created by 陸瑋恩 on 2021/10/27.
//

import UIKit

class ViewController: UIViewController {
    
    private let signInManager = SignInManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInManager.signIn(email: "nicklu717@gmail.com", password: "12345678") { result in
            switch result {
            case let .success(response):
                print(response.data.user.name)
            case let .failure(error):
                print(error)
            }
        }
    }
}
