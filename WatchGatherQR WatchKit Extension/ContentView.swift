//
//  ContentView.swift
//  WatchGatherQR WatchKit Extension
//
//  Created by K.Hatano on 2021/09/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        WatchQRCodeListView()
            .onAppear {
                app.syncWithPhone()
            }
            .environmentObject(app.watchQRInfoList)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(WatchQRInfoList())
    }
}
