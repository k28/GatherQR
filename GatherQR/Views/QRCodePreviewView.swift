//
//  QRCodePreviewView.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/09.
//

import SwiftUI

struct QRCodePreviewView: View {
    var item: QRInfoModelProtocol
    
    var body: some View {
        VStack {
            Image(uiImage: item.qrcode())
                .resizable()
                .scaledToFit()
        }
        .navigationTitle(item.title)
    }
}

struct QRCodePreviewView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodePreviewView(item: QRInfoModel())
    }
}
