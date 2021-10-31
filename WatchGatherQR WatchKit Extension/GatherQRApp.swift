//
//  GatherQRApp.swift
//  WatchGatherQR WatchKit Extension
//
//  Created by K.Hatano on 2021/09/25.
//

import SwiftUI

@main
struct GatherQRApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
