//
//  WatchQRCodePreviewView.swift
//  WatchGatherQR WatchKit Extension
//
//  Created by K.Hatano on 2021/10/31.
//

import SwiftUI

struct WatchQRCodePreviewView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    var item: WatchQRInfoProtocol
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                QRCodeImageView(image: item.qrCode, viewSize: geometry.size)
            }
        }
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // Make sure that the screen rotates so that it doesn't disappear when turn the wrist.
            WKApplication.shared().isAutorotating = true
            app.phoneSyncManager.sendShowQRCode()
        }
        .onDisappear {
            WKApplication.shared().isAutorotating = false
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                app.phoneSyncManager.sendShowQRCode()
                break
            case .inactive:
                // The app has become inactive.
                break
            case .background:
                // The app has moved to the background.
                break
            @unknown default:
                fatalError("The app has entered an unknown state.")
            }

        }

    }
    
}

struct WatchQRCodePreviewView_Previews: PreviewProvider {
    static var previews: some View {
        WatchQRCodePreviewView(item: WatchQRInfoStb.make(title: "Test 1"))
    }
}
