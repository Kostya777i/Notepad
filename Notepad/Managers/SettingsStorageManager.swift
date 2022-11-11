//
//  StoringSettingsManager.swift
//  Notepad
//
//  Created by Konstantin Losev on 01.11.2022.
//

import Foundation

class SettingsStorageManager {
    
    static let shared = SettingsStorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let fileExtension = "plist"
    private let keyForPasswordSetting = "settingsPassword"
    private let keyForFaceIDSetting = "settingFaceID"
    private let keyForPassword = "password"
    private let fileDirectory = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
    private var archivePasswordSettingURL: URL!
    private var archivePasswordURL: URL!
    private var archiveFaceIDSetting: URL!
    
    private init() { if #available(iOS 16.0, *) {
        archivePasswordSettingURL = fileDirectory.appending(component: keyForPasswordSetting).appendingPathExtension(fileExtension)
        archiveFaceIDSetting = fileDirectory.appending(component: keyForFaceIDSetting).appendingPathExtension(fileExtension)
        archivePasswordURL = fileDirectory.appending(component: keyForPassword).appendingPathExtension(fileExtension)
    } else {
        archivePasswordSettingURL = fileDirectory.appendingPathComponent(keyForPasswordSetting).appendingPathExtension(fileExtension)
        archiveFaceIDSetting = fileDirectory.appendingPathComponent(keyForFaceIDSetting).appendingPathExtension(fileExtension)
        archivePasswordURL = fileDirectory.appendingPathComponent(keyForPassword).appendingPathExtension(fileExtension)
    }
    }
    
    func saveAccessSettingsByPassword(with setting: AccessSettings) {
        var settings = fetchAccessSettingsByPassword()
        settings = setting
        
        guard let data = try? JSONEncoder().encode(settings) else { return }
        userDefaults.set(data, forKey: keyForPasswordSetting)
    }
    
    func fetchAccessSettingsByPassword() -> AccessSettings {
        guard let data = userDefaults.object(forKey: keyForPasswordSetting) as? Data else {
            return AccessSettings(accessSetting: false)
        }
        guard let settings = try? JSONDecoder().decode(AccessSettings.self, from: data) else {
            return AccessSettings(accessSetting: false)
        }
        return settings
    } 
    
    func saveAccessSettingsByFaceID(with setting: SettingFaceID) {
        var settings = fetchAccessSettingsByFaceID()
        settings = setting
        
        guard let data = try? JSONEncoder().encode(settings) else { return }
        userDefaults.set(data, forKey: keyForFaceIDSetting)
    }
    
    func fetchAccessSettingsByFaceID() -> SettingFaceID {
        guard let data = userDefaults.object(forKey: keyForFaceIDSetting) as? Data else {
            return SettingFaceID(faceIDEnable: false)
        }
        guard let settings = try? JSONDecoder().decode(SettingFaceID.self, from: data) else {
            return SettingFaceID(faceIDEnable: false)
        }
        return settings
    }
    
    func savePassword(with password: CodePassword) {
        var newPassword = fetchPassword()
        newPassword = password
        
        guard let data = try? JSONEncoder().encode(newPassword) else { return }
        userDefaults.set(data, forKey: keyForPassword)
    }
    
    func fetchPassword() -> CodePassword {
        guard let data = userDefaults.object(forKey: keyForPassword) as? Data else {
            return CodePassword(password: "")
        }
        guard let password = try? JSONDecoder().decode(CodePassword.self, from: data) else {
            return CodePassword(password: "")
        }
        return password
    }
}
