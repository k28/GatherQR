//
//  ContentView.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/08.
//

import SwiftUI

struct ContentView: View {
        
    var qecodeList: QRInfoListProtocol
    let scanQRCodeView = ScanQRCodeView()
    
    var body: some View {
        QRCodeInfoList(model: qecodeList)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(qecodeList: QRInfoList())
    }
}
