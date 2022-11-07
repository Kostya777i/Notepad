//
//  KeyboardExtension.swift
//  Notepad
//
//  Created by Konstantin Losev on 03.11.2022.
//

import UIKit

extension UIView {
    
    func makeDissmissKeyboardTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.endEditing))
        self.addGestureRecognizer(tap)
    }
}
