//
//  ContentView.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/08.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    var qecodeList: QRInfoListProtocol
    
    var body: some View {
        let qrInfoList = QRCodeInfoList(model: qecodeList)
        TabView(selection: $selection) {
            qrInfoList
                .tabItem {
                    VStack {
                        Image(systemName: "list.dash")
                        Text("QRCodeList")
                    }
                }.tag(0)
            ScanQRCodeView()
                .tabItem {
                    VStack {
                        Image(systemName: "qrcode.viewfinder")
                        Text("Add")
                    }
                }.tag(1)
            // TODO 情報表示のTabを追加する
                .onChange(of: selection){ selection in
                    if selection == 0 {
                        // Viewをリフレッシュさせたい...
                        qrInfoList.reloadData()
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(qecodeList: QRInfoList())
    }
}
