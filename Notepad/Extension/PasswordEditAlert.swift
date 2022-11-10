//
//  PasswordEditAlert.swift
//  Notepad
//
//  Created by Konstantin Losev on 05.11.2022.
//

import UIKit

extension SettingsViewController {
    
    func showAlertForPassword(completion: (() -> Void)? = nil) {
        let title = "Новый Пароль"
        
        let alert = AlertController(title: title, message: "Enter new Password", preferredStyle: .alert)
        
        alert.action() { newValue in
            SettingsStorageManager.shared.savePassword(with: CodePassword(password: newValue))
        }
        
        present(alert, animated: true)
    }
}
