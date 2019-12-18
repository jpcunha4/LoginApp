//
//  SignUpPresenter.swift
//  LoginTest
//
//  Created by Joao Paulo Cunha Ávila on 17/12/19.
//  Copyright © 2019 Joao Paulo Cunha Ávila. All rights reserved.
//

import Foundation

protocol signUpDelegate {
    func isValidUser(isValid: Bool)
    func updateNickname(_ nickname: String)
    func updateCpf(_ cpf: String)
    func updatePassword(_ password: String)
    func updatePasswordVerification(_ password: String)
}

class SignUpPresenter {
    
    var delegate: signUpDelegate?
    let validator = Validator()
    let interactor = SignUpInteractor()
    
}
