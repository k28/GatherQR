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
                .onDelete(perform: removeItem)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .navigationTitle("QRCode List")
        }
        .onAppear() {
            qrcodeList = model.qrInfoList()
        }
    }
    
    func removeItem(offsets: IndexSet) {
        offsets.forEach { index in
            let deleteItem = qrcodeList[index]
            if model.remove(item: deleteItem) {
                self.qrcodeList.remove(at: index)
            }
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
