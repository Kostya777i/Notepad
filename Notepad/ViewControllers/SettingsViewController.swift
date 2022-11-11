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
        currentValueFaceIDSwitch()
        currentValueAccessSwitch()
        settingView()
    }
    
    @IBAction func accessSwitchSetting() {
        if accessByAutenticationSwitch.isOn {
            SettingsStorageManager.shared.saveAccessSettingsByPassword(with: AccessSettings(accessSetting: true))
        } else {
            SettingsStorageManager.shared.saveAccessSettingsByPassword(with: AccessSettings(accessSetting: false))
        }
        
        labelAccessSettings()
        passwordCheckForFirstLaunch()
    }
    
    @IBAction func authenticationSwitch() {
        if currentAuthenticationSwitch.isOn {
            SettingsStorageManager.shared.saveAccessSettingsByFaceID(with: SettingFaceID(faceIDEnable: true))
        } else {
            SettingsStorageManager.shared.saveAccessSettingsByFaceID(with: SettingFaceID(faceIDEnable: false))
        }
        
        labelFaceIDSettings()
    }
    
    @IBAction func editPasswordButtonPressed() {
        showAlertForPassword()
    }
    
    private func settingView() {
        editPasswordButton.setTitle("Edit Password", for: .normal)
        labelAccessSettings()
        labelFaceIDSettings()
    }
    
    private func passwordCheckForFirstLaunch() {
        if SettingsStorageManager.shared.fetchPassword().password == "" {
            showAlertForPassword()
        } 
    }
    
    private func hidingSettings(enabled: Bool) {
        currentAuthenticationLabel.isHidden = enabled
        currentAuthenticationSwitch.isHidden = enabled
        editPasswordButton.isHidden = enabled
        deletePasswordButton.isHidden = enabled
    }
    
    private func labelAccessSettings() {
        if accessByAutenticationSwitch.isOn {
            accesByAuthenticationLabel.text = "Блокировка доступа: ON/off"
            accesByAuthenticationLabel.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            hidingSettings(enabled: false)
        } else if accessByAutenticationSwitch.isOn == false {
            accesByAuthenticationLabel.text = "Блокировка доступа: on/OFF"
            accesByAuthenticationLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            hidingSettings(enabled: true)
        }
    }
    
    private func labelFaceIDSettings() {
        if currentAuthenticationSwitch.isOn {
            currentAuthenticationLabel.text = "Face ID: ON"
        } else if currentAuthenticationSwitch.isOn == false {
            currentAuthenticationLabel.text = "Face ID: OFF"
        }
    }
    
    private func currentValueAccessSwitch() {
        let currentValue = SettingsStorageManager.shared.fetchAccessSettingsByPassword()
        
        if currentValue.accessSetting == false {
            accessByAutenticationSwitch.isOn = false
        } else {
            accessByAutenticationSwitch.isOn = true
        }
    }
    
    private func currentValueFaceIDSwitch() {
        let currentValue = SettingsStorageManager.shared.fetchAccessSettingsByFaceID()
        
        if currentValue.faceIDEnable == false {
            currentAuthenticationSwitch.isOn = false
        } else {
            currentAuthenticationSwitch.isOn = true
        }
    }
}
