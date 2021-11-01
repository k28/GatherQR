//
//  WatchQRCodeListView.swift
//  WatchGatherQR WatchKit Extension
//
//  Created by K.Hatano on 2021/10/31.
//

import SwiftUI

struct WatchQRCodeListView: View {
    var body: some View {
        NavigationLink(destination: {
            WatchQRCodePreviewView(item: QRInfoModel())
        }) {
            Text("Show QRCode!")
        }
    }
}

struct WatchQRCodeListView_Previews: PreviewProvider {
    static var previews: some View {
        WatchQRCodeListView()
    }
}
