//
//  Auth_without_storyboardApp.swift
//  Auth without storyboard
//
//  Created by Азамат Кемал on 13.05.2022.
//

import SwiftUI
import Firebase
import FirebaseAuth

let screen = UIScreen.main.bounds

@main
struct Auth_without_storyboardApp: App {
    
    // Чтобы приложение увидело наш класс AppDelegate !!!!!!!!!!
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            AuthView()
//            PresentSimple()
        }
    }
    
    // from UIKIT, женим наше приложение с Firebase
    
    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            
            FirebaseApp.configure()
            print("App Delegate launched")
            
            return true
        }
    }
}
