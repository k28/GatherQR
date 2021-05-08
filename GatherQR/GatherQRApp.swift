//
//  GatherQRApp.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/08.
//

import SwiftUI

@main
struct GatherQRApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(item: QRInfoModel())
        }
    }
}
