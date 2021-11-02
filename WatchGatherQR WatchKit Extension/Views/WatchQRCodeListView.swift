//
//  WatchQRCodeListView.swift
//  WatchGatherQR WatchKit Extension
//
//  Created by K.Hatano on 2021/10/31.
//

import SwiftUI

struct WatchQRCodeListView: View {
    
    @EnvironmentObject var qrcodeList: WatchQRInfoList
    
    var body: some View {
        
        List {
            ForEach(qrcodeList.qrInfoList, id: \.uuid) { item in
                NavigationLink(destination: WatchQRCodePreviewView(item: item)) {
                    Text(item.title)
                }
            }
        }
        
    }
}

struct WatchQRCodeListView_Previews: PreviewProvider {
    static var previews: some View {
        WatchQRCodeListView()
    }
}
