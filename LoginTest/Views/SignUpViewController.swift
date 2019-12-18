//
//  SignUpViewController.swift
//  LoginTest
//
//  Created by Joao Paulo Cunha Ávila on 17/12/19.
//  Copyright © 2019 Joao Paulo Cunha Ávila. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var cpfTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    let presenter = SignUpPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.delegate = self
    }

    @IBAction func signUp(_ sender: Any) {
        
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

extension SignUpViewController: signUpDelegate {
    func isValidUser(isValid: Bool) {
        
    }
    
    func updateNickname(_ nickname: String) {
        
    }
    
    func updateCpf(_ cpf: String) {
        
    }
    
    func updatePassword(_ password: String) {
        
    }
    
    func updatePasswordVerification(_ password: String) {
        
    }
    
    
}
