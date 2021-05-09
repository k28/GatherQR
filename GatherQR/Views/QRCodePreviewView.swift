//
//  QRCodePreviewView.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/09.
//

import SwiftUI

struct QRCodePreviewView: View {
    var item: QRInfoModelProtocol
    @State var brightness: CGFloat = 1.0
    
    var body: some View {
        VStack {
            Image(uiImage: item.qrcode())
                .resizable()
                .scaledToFit()
        }
        .navigationTitle(item.title)
        
        .onAppear() {
            if UIScreen.main.brightness != 1.0 {
                brightness = UIScreen.main.brightness
                UIScreen.main.brightness = 1.0
            }
        }
        .onDisappear() {
            if brightness != 1.0 {
                UIScreen.main.brightness = brightness
            }
        }
    }
}

struct QRCodePreviewView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodePreviewView(item: QRInfoModel())
    }
}
