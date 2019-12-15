//
//  StringExtension.swift
//  LoginTest
//
//  Created by Joao Paulo Cunha Ávila on 14/12/19.
//  Copyright © 2019 Joao Paulo Cunha Ávila. All rights reserved.
//

import UIKit

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
