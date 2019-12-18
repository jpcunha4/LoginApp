//
//  ViewController.swift
//  LoginTest
//
//  Created by Joao Paulo Cunha Ávila on 12/12/19.
//  Copyright © 2019 Joao Paulo Cunha Ávila. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var cpfTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: Variables
    var presenter = LoginPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.delegate = self
    }

    @IBAction func loginAction(_ sender: Any) {
        let cpf = presenter.user.cpf
        let password = presenter.user.password
        print(cpf, password)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
}

// MARK: TextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let isDeleteButton = string.count == 0 && range.length > 0
        
        switch textField.tag {
        // CPF textField
        case 1: presenter.updateCpf(updateChar: string, needsToDelete: isDeleteButton)
        // Password textField
        case 2: presenter.updatePassword(updateChar: string, needsToDelete: isDeleteButton)
        default: break
        }
        
        return false
    }
}

// MARK: LoginDelegate
extension LoginViewController: LoginDelegate {
    func updateCPF(_ cpf: String) {
        self.cpfTextField.text = cpf
    }
    
    func updatePassword(_ password: String) {
        self.passwordTextField.text = password
    }
    
    func isValidUser(_ isValid: Bool) {
        loginButton.isEnabled = isValid
    }
}
