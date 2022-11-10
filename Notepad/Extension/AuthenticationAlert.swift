//
//  AuthenticationAlert.swift
//  Notepad
//
//  Created by Konstantin Losev on 03.11.2022.
//

import UIKit

extension AuthenticationViewController {
    
    func showAlert(with title: String, and message: String) {
        var titleButton = "Повторить"
        if self.passwordTextField.text == "" { titleButton = "OK" }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: titleButton, style: .default) {
            _ in self.passwordTextField.text = ""
            self.passwordTextField.becomeFirstResponder()
        }
            
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
