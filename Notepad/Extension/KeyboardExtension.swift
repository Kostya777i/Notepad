//
//  KeyboardExtension.swift
//  Notepad
//
//  Created by Konstantin Losev on 03.11.2022.
//

import UIKit

// MARK: - Extension for function key "Done" in keyboard and application values

extension AuthenticationViewController {
    
    // Hiding keyboard with tap and applying entered value
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
        
        doneButton()
    }
    
    func addDoneButton(_ textField: UITextField) {
        
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(didTapDone))
    
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil)
    
    keyboardToolbar.items = [flexBarButton, doneButton]
        textField.inputAccessoryView = keyboardToolbar
    }

    @objc private func didTapDone() {
        view.endEditing(true)
        doneButton()
    }
}
