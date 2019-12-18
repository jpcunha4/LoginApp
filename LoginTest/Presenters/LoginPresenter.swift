//
//  loginPresenter.swift
//  LoginTest
//
//  Created by Joao Paulo Cunha Ávila on 12/12/19.
//  Copyright © 2019 Joao Paulo Cunha Ávila. All rights reserved.
//

protocol LoginDelegate {
    func isValidUser(_ isValid: Bool)
    func updateCPF(_ cpf:String)
    func updatePassword(_ password: String)
}

class LoginPresenter {
    
    var user = User()
    var delegate: LoginDelegate?
    var interactor = LoginInteractor()
    
    // MARK: Updates
    
    func updateCpf(updateChar: String, needsToDelete: Bool) {
        var cpf = user.cpf
        if cpf.unmaskedCPF.count == 11 && !needsToDelete { return }
        
        if needsToDelete { _ = cpf.popLast() }
        let unmaskedString = "\(cpf.unmaskedCPF)\(updateChar)"
        
        user.cpf = unmaskedString.maskedCPF
        
        delegate?.updateCPF(user.cpf)
        isValidUser()
    }
    
    func updatePassword(updateChar: String, needsToDelete: Bool) {
        var password = user.password
        if password.count == 12 && !needsToDelete { return }
        
        if needsToDelete { _ = password.popLast() }
        user.password = "\(password)\(updateChar)"
        
        delegate?.updatePassword(user.password)
        isValidUser()
    }
    
    private func isValidUser() {
        let (cpf, password) = user.splitUser()
        
        let isValidCpf = interactor.validateCPF(cpf)
        let isValidPassword = interactor.validatePassword(password)
        
        delegate?.isValidUser(isValidCpf && isValidPassword)
    }
}
