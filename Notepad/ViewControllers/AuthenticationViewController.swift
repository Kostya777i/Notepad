//
//  AuthenticationViewController.swift
//  Notepad
//
//  Created by Konstantin Losev on 01.11.2022.
//

import UIKit
import LocalAuthentication

class AuthenticationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var constraintPasswordTaxtField: NSLayoutConstraint!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
        self.passwordTextField.delegate = self
        buttonSetting()
        addDoneButton(passwordTextField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        constraintPasswordTaxtField.constant -= view.bounds.width
        
        if SettingsStorageManager.shared.fetchAccessSettingsByFaceID().faceIDEnable == true {
            faceID()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateLayouts()
    }
    
    @IBAction func doneButton() {
        // Check for nil for call showAlert if the input field is empty
        guard let inputPassword = passwordTextField.text, !inputPassword.isEmpty else {
            showAlert(with: "Поле пароля не заполнено", and: "Введите пароль")
            return
        }
        // Check password
        verificationPassword()
    }
    
    private func buttonSetting() {
        button.tintColor = .white
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
    }
    
    private func verificationPassword() {
        let currentPassword = SettingsStorageManager.shared.fetchPassword()
        
        if passwordTextField.text == currentPassword.password {
            performSegue(withIdentifier: "access", sender: nil)
        } else {
            showAlert(with: "Неверный пароль", and: "Попробуйте еще раз")
        }
    }
    
    private func faceID() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authorize with Face ID"
            
            context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics, localizedReason: reason
            ) { success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        return
                    }
                    self.passwordTextField.text = SettingsStorageManager.shared.fetchPassword().password
                    self.verificationPassword()
                }
            }
        }
    }
    
    private func animateLayouts() {
        constraintPasswordTaxtField.constant = 220
        animateLauout(duration: 0.6, delay: 0.1)
    }
}

private extension AuthenticationViewController {
    
    func animateLauout(duration: Double, delay: Double) {
        UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseInOut]) {
            [weak self] in
                self?.view.layoutIfNeeded()
        }
    }
}
