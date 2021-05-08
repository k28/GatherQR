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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(qecodeList: QRInfoList())
    }
}
