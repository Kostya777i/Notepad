//
//  Settings.swift
//  Notepad
//
//  Created by Konstantin Losev on 01.11.2022.
//

struct AccessSettings: Codable {
    let accessSetting: Bool
}

struct CodePassword: Codable {
    let password: String
}

struct SettingFaceID: Codable {
    let faceIDEnable: Bool
}
