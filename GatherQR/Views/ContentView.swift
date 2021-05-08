//
//  ContentView.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/08.
//

import SwiftUI

struct ContentView: View {
    var item: QRInfoModelProtocol
    
    var body: some View {
        HStack {
            Text("Hello!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(item: QRInfoModel())
    }
}
