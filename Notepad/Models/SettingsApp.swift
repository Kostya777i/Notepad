//
//  Settings.swift
//  Notepad
//
//  Created by Konstantin Losev on 01.11.2022.
//

struct SettingsApp: Codable {
    let faceIDEnable: Bool
}

struct CodePassword: Codable {
    let password: String
}
