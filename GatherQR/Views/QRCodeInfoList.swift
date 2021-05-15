//
//  QRCodeInfoList.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/15.
//

import SwiftUI

struct QRCodeInfoList: View {
    var qecodeList: QRInfoListProtocol

    var body: some View {
        NavigationView {
            List {
                ForEach(qecodeList.qrInfoList(), id: \.id) { item in
                    NavigationLink(destination: QRCodePreviewView(item: item)) {
                        QRCodeInfoRow(item: item)
                    }
                }
            }
            .navigationTitle("QRCode List")
        }
    }
}

struct QRCodeInfoList_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(qecodeList: QRInfoList())
    }
}
