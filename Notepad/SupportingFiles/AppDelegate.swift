//
//  AppDelegate.swift
//  Notepad
//
//  Created by Konstantin Losev on 01.11.2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        //        window = UIWindow(frame: view?.window?.windowScene?.screen)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let access = SettingsStorageManager.shared.fetchSettings().faceIDEnable
        if access == true {
            window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "authenticalView")
        } else {
            window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "notesView")
        }
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}

