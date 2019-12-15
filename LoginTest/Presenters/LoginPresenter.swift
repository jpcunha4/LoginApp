//
//  loginPresenter.swift
//  LoginTest
//
//  Created by Joao Paulo Cunha Ávila on 12/12/19.
//  Copyright © 2019 Joao Paulo Cunha Ávila. All rights reserved.
//

import UIKit

protocol LoginDelegate {
    func isValidUser(_ cpf: String,_ password: String)
    func updateCPF(_ cpf:String)
    func updatePassword(_ password: String)
}

class LoginPresenter: NSObject {
    
    var user = User()
    var delegate: LoginDelegate?
    
    //MARK: Validations
    
    func validateCPF(_ cpf: String) -> Bool {
        
        for x in 0..<10 {
            let cpfString = "\(x)\(x)\(x).\(x)\(x)\(x).\(x)\(x)\(x)-\(x)\(x)"
            if cpf == cpfString { return false }
        }
        
        let cpfArray = Array(cpf.unmaskedCPF)
        
        // Multiply the first 9 digits from 10 to 2
        let test1 = cpfArray.enumerated().map{ (index, value) -> Int in multiplyValue(index, value, 10) }.reduce(0) {$0 + $1}
        // Multiply the first 10 digits from 11 to 2
        let test2 = cpfArray.enumerated().map{ (index, value) -> Int in multiplyValue(index, value, 11) }.reduce(0) {$0 + $1}
        
        var result1 = false
        var result2 = false
        
        if cpfArray.count == 11 {
            // Test if the rest of test1 * 10 by 11 is equal to the tenth digit
            if let tenthDigit = cpfArray[9].wholeNumberValue {
                result1 = (test1 * 10) % 11 == tenthDigit
            }
            
            // Test if the rest of test2 * 10 by 11 is equal to the eleventh digit
            if let eleventhDigit = cpfArray[10].wholeNumberValue {
                result2 = (test2 * 10) % 11 == eleventhDigit
            }
        }
        
        return result1 && result2
    }
    
    private func multiplyValue(_ index: Int,_ value: String.Element,_ limit: Int) -> Int{
        if let val = value.wholeNumberValue {
            return index < (limit - 1) ? val * (limit - index) : 0
        }
        
        return 0
    }
    
    func validatePassword(_ password: String) -> Bool {
        let size = password.count
        let hasUpperCase = password.range(of: #"[A-Z]"#, options: .regularExpression) != nil
        let hasNumber = password.range(of: #"\d"#, options: .regularExpression) != nil
        let hasSymbol = password.range(of: #"\W"#, options: .regularExpression) != nil
        let hasNoSpaces = !password.contains(" ")
            
        return size >= 8 && size <= 12 && hasUpperCase && hasNumber && hasSymbol && hasNoSpaces
    }
    
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
        
        delegate?.isValidUser(cpf, password)
    }
}

// MARK: String Extension

extension String {
    var maskedCPF: String {
        var maskedCPF = self
        
        maskedCPF = maskedCPF.replacingOccurrences(of: "(\\d{3})(\\d+)", with: "$1.$2", options: .regularExpression)
        maskedCPF = maskedCPF.replacingOccurrences(of: "(\\d{3}.\\d{3})(\\d+)", with: "$1.$2", options: .regularExpression)
        maskedCPF = maskedCPF.replacingOccurrences(of: "(\\d{3}.\\d{3}.\\d{3})(\\d+)", with: "$1-$2", options: .regularExpression)
        
        return maskedCPF
    }
    
    var unmaskedCPF: String {
        return self.replacingOccurrences(of: #"[.-]"#, with: "", options: .regularExpression)
    }
}
