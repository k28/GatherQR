//
//  QRCodePreviewView.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/09.
//

import SwiftUI

struct QRCodePreviewView: View {
    var item: QRInfoModelProtocol
    @State var isViewAppear = false
    @State var brightness: CGFloat = 1.0

    var body: some View {
        VStack {
            GeometryReader { geometry in
                QRCodeImageView(image: item.qrcode(), viewSize: geometry.size)
            }
        }

        .navigationTitle(item.title)
        .onAppear() {
            isViewAppear = true
            moveBrightnessMaxIfNeed()
            app.logEventCount(itemID: .ShowCode, ItemName: "Show")
        }
        .onDisappear() {
            isViewAppear = false
            backBrightnessToBefore()
        }
        .onReceive(NotificationCenter.default.publisher(
            for: UIApplication.willResignActiveNotification
        )) { _ in
            backBrightnessToBefore()
        }
        .onReceive(NotificationCenter.default.publisher(
            for: UIApplication.didBecomeActiveNotification
        )) { _ in
            moveBrightnessMaxIfNeed()
        }

    }
    
    func moveBrightnessMaxIfNeed() {
        if !isViewAppear {
            return
        }
        if UIScreen.main.brightness != 1.0 {
            brightness = UIScreen.main.brightness
            UIScreen.main.brightness = 1.0
        }
    }
    
    func backBrightnessToBefore() {
        if brightness != 1.0 {
            UIScreen.main.brightness = brightness
        }
    }
    
}

struct QRCodePreviewView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodePreviewView(item: QRInfoModel())
    }
}
