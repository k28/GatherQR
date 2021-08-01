//
//  ContentView.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/08.
//

import SwiftUI

struct ContentView: View {
        
    var qecodeList: QRInfoListProtocol

    var body: some View {
        QRCodeInfoList(model: qecodeList)
            .environmentObject(ObservedInfo())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(qecodeList: QRInfoList())
            .environmentObject(ObservedInfo())
    }
}
