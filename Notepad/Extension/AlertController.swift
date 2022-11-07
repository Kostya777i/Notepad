//
//  AlertController.swift
//  Notepad
//
//  Created by Konstantin Losev on 05.11.2022.
//

import UIKit

class AlertController: UIAlertController {
    func action(completion: @escaping (String) -> Void) {
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            guard let newValue = self.textFields?.first?.text else { return }
            guard !newValue.isEmpty else { return }
            completion(newValue)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
        addTextField() { _ in
            self.textFields?.first?.keyboardType = .numberPad
        }
    }
}
