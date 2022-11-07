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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.passwordTextField.delegate = self
        view.makeDissmissKeyboardTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        constraintPasswordTaxtField.constant -= view.bounds.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateLayouts()
    }
    
    @IBAction func doneButton() {
        
        // Проверка на nil для вызова showAlert если поле ввода пусто
        guard let inputPassword = passwordTextField.text, !inputPassword.isEmpty else {
            showAlert(with: "Поле пароля не заполнено", and: "Введите пароль")
            return
        }
        
        // Проверка пароля
        verificationPassword()
    }
    
    private func verificationPassword() {
        let currentPassword = SettingsStorageManager.shared.fetchPassword()
        
        if passwordTextField.text == currentPassword.password {
            performSegue(withIdentifier: "access", sender: nil)
        } else {
            passwordAlert(with: "Невепный пароль", and: "Попробуйте еще раз")
        }
    }
    
    private func faceID() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please"
            
            context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                    DispatchQueue.main.async {
                        guard success, error == nil else {
                            return
                        }
                    }
                }
        }
    }
    
    private func animateLayouts() {
        constraintPasswordTaxtField.constant = 200
        animateLauout(duration: 0.6, delay: 0.2)
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
