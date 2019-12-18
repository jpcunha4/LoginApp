//
//  loginModel.swift
//  LoginTest
//
//  Created by Joao Paulo Cunha Ávila on 12/12/19.
//  Copyright © 2019 Joao Paulo Cunha Ávila. All rights reserved.
//

import UIKit

class User: NSObject {
    var nickname: String = ""
    var cpf: String = ""
    var password: String = ""
    
    func splitUser() -> (cpf: String, password: String) {
        return (cpf, password)
    }
}

