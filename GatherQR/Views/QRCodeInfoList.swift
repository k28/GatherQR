//
//  QRCodeInfoList.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/15.
//

import SwiftUI

struct QRCodeInfoList: View {
    var model: QRInfoListProtocol
    @State var qrcodeList: [QRInfoModelProtocol] = []

    var body: some View {
        NavigationView {
            List {
                ForEach(qrcodeList, id: \.uuid) { item in
                    NavigationLink(destination: QRCodePreviewView(item: item)) {
                        QRCodeInfoRow(item: item)
                    }
                }
            }
            .navigationTitle("QRCode List")
        }
        .onAppear() {
            qrcodeList = model.qrInfoList()
        }
    }
    
    func reloadData() {
        qrcodeList = model.qrInfoList()
    }
}

struct QRCodeInfoList_Previews: PreviewProvider {
    static var previews: some View {
        let model = QRInfoList()
        ContentView(qecodeList: model)
    }
}
