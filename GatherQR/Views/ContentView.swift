//
//  ContentView.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/08.
//

import SwiftUI

struct ContentView: View {
    
    enum TabSelection: Int {
        case qrInfoList = 0
        case scanQRCode = 1
        case unknown
        
        static func make(_ section: Int) -> TabSelection {
            return TabSelection.init(rawValue: section) ?? .unknown
        }
    }
    
    @State private var selection = 0
    var qecodeList: QRInfoListProtocol
    let scanQRCodeView = ScanQRCodeView()
    
    var body: some View {
        let qrInfoList = QRCodeInfoList(model: qecodeList)
        TabView(selection: $selection) {
            qrInfoList
                .tabItem {
                    VStack {
                        Image(systemName: "list.dash")
                        Text("QRCodeList")
                    }
                }.tag(TabSelection.qrInfoList.rawValue)
            scanQRCodeView
                .tabItem {
                    VStack {
                        Image(systemName: "qrcode.viewfinder")
                        Text("Add")
                    }
                }.tag(TabSelection.scanQRCode.rawValue)
            // TODO 情報表示のTabを追加する
                
                // Tabが切り替わった時の処理などを記述する
                .onChange(of: selection){ selection in
                    switch TabSelection.make(selection) {
                    case .qrInfoList:
                        qrInfoList.reloadData()
                    case .scanQRCode:
                        scanQRCodeView.onViewAppeard()
                    case .unknown:
                        break
                    }
                    
                    if TabSelection.make(selection) != .scanQRCode {
                        // QRコード取り込み画面以外
                        scanQRCodeView.onViewDisappeard()
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
