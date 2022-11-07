//
//  StoringSettingsManager.swift
//  Notepad
//
//  Created by Konstantin Losev on 01.11.2022.
//

import Foundation

class SettingsStorageManager {
    
    static let shared = SettingsStorageManager()
    
    private let defaultPassword = "1234"
    private let userDefaults = UserDefaults.standard
    private let fileExtension = "plist"
    private let keyForSettings = "settings"
    private let keyForPassword = "password"
    private let fileDirectory = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
    private var archiveSettingsURL: URL!
    private var archivePasswordURL: URL!
    
    private init() { if #available(iOS 16.0, *) {
        archiveSettingsURL = fileDirectory.appending(component: keyForSettings).appendingPathExtension(fileExtension)
        archivePasswordURL = fileDirectory.appending(component: keyForPassword).appendingPathExtension(fileExtension)
    } else {
        archiveSettingsURL = fileDirectory.appendingPathComponent(keyForSettings).appendingPathExtension(fileExtension)
        archivePasswordURL = fileDirectory.appendingPathComponent(keyForPassword).appendingPathExtension(fileExtension)
    }
    }
    
    func saveSettings(with setting: SettingsApp) {
        var settings = fetchSettings()
        settings = setting
        
        guard let data = try? JSONEncoder().encode(settings) else { return }
        userDefaults.set(data, forKey: keyForSettings)
    }
    
    func fetchSettings() -> SettingsApp {
        guard let data = userDefaults.object(forKey: keyForSettings) as? Data else {
            return SettingsApp(faceIDEnable: false)
        }
        guard let settings = try? JSONDecoder().decode(SettingsApp.self, from: data) else {
            return SettingsApp(faceIDEnable: false)
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
            return CodePassword(password: defaultPassword)
        }
        guard let password = try? JSONDecoder().decode(CodePassword.self, from: data) else {
            return CodePassword(password: defaultPassword)
        }
        return password
    }
}
