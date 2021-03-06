//
//  GatherQRApp.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/08.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        app.initialize()
        return true
    }
    
}

@main
struct GatherQRApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView(qecodeList: QRInfoList())
        }
    }
}

let app = AppCommon()
