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
            Text(item.title)
                .padding()
            Image(uiImage: item.qrcode())
                .resizable()
                .scaledToFit()
        }
        
    }
}

struct QRCodePreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(item: QRInfoModel())
    }
}
