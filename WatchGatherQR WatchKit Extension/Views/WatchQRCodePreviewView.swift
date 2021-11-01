//
//  WatchQRCodePreviewView.swift
//  WatchGatherQR WatchKit Extension
//
//  Created by K.Hatano on 2021/10/31.
//

import SwiftUI

struct WatchQRCodePreviewView: View {
    
    var item: QRInfoModelProtocol
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                QRCodeImageView(image: item.qrcode(), viewSize: geometry.size)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

struct WatchQRCodePreviewView_Previews: PreviewProvider {
    static var previews: some View {
        WatchQRCodePreviewView(item: QRInfoModel())
    }
}