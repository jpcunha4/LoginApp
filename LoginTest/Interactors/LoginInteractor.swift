//
//  LoginInteractor.swift
//  LoginTest
//
//  Created by Joao Paulo Cunha Ávila on 17/12/19.
//  Copyright © 2019 Joao Paulo Cunha Ávila. All rights reserved.
//

class LoginInteractor {
    
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
}
