//
//  SettingsViewController.swift
//  Notepad
//
//  Created by Konstantin Losev on 01.11.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var accesByAuthenticationLabel: UILabel!
    @IBOutlet weak var currentAuthenticationLabel: UILabel!
    
    @IBOutlet weak var accessByAutenticationSwitch: UISwitch!
    @IBOutlet weak var currentAuthenticationSwitch: UISwitch!
    
    @IBOutlet weak var editPasswordButton: UIButton!
    @IBOutlet weak var deletePasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentValueSwitchFaceID()
        settingView()
    }
    
    @IBAction func faceIDSwitchSetting() {
        if accessByAutenticationSwitch.isOn {
            SettingsStorageManager.shared.saveSettings(with: SettingsApp(faceIDEnable: true))
        } else {
            SettingsStorageManager.shared.saveSettings(with: SettingsApp(faceIDEnable: false))
        }
        
        labelSetting()
    }
    
    @IBAction func authenticationSwitch() {
    }
    
    @IBAction func editPasswordButtonPressed() {
        showAlert()
    }
    
    private func settingView() {
        editPasswordButton.setTitle("Edit Password", for: .normal)
        labelSetting()
    }
    
    private func labelSetting() {
        if accessByAutenticationSwitch.isOn {
            accesByAuthenticationLabel.text = "Блокировка доступа: ON/off"
            accesByAuthenticationLabel.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        } else if accessByAutenticationSwitch.isOn == false {
            accesByAuthenticationLabel.text = "Блокировка доступа: on/OFF"
            accesByAuthenticationLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
    }
    
    private func currentValueSwitchFaceID() {
        let currentValue = SettingsStorageManager.shared.fetchSettings()
        
        if currentValue.faceIDEnable == false {
            accessByAutenticationSwitch.isOn = false
        } else {
            accessByAutenticationSwitch.isOn = true
        }
    }
}
