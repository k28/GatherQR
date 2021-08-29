//
//  QRCodeInfoList.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/15.
//

import SwiftUI

struct QRCodeInfoList: View {
    @EnvironmentObject var object: ObservedInfo
    
    @State private var refresh = UUID()
    var model: QRInfoListProtocol
//    @State var qrcodeList: [QRInfoModelProtocol] = []
    @State private var showingScanView = false


    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(object.qrcodeList, id: \.uuid) { item in
                        NavigationLink(destination: QRCodePreviewView(item: item)) {
                            QRCodeInfoRow(item: QRCodeInfoRowViewModel(model: item))
                        }
                    }
                    .onDelete(perform: removeItem)
                    
                }
                
                // QRコードをスキャンして登録する画面
                NavigationLink(destination: ScanQRCodeView(), isActive: $showingScanView) {
                    EmptyView()
                }
                
                // Bottom Add Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showingScanView = true
                        }) {
                            ZStack {
                                VStack {
                                    Image(systemName: "qrcode.viewfinder")
                                        .resizable()
                                        .frame(width: 32, height: 32, alignment: .center)
                                        .accentColor(.white)
                                        .padding([.bottom], 10)
                                }
                                .frame(width: 78, height: 78)
                                
                                Text(app.loadString("Add"))
                                    .accentColor(.white)
                                    .font(.footnote)
                                    .offset(x: 0, y: 23)
                            }
                        }
                        .background(Color.blue)
                        .cornerRadius(38.5)
                        .padding()
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 3,
                                x: 3,
                                y: 3)
                    }
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .id(refresh)
            .navigationTitle(app.loadString("QR code List"))
        }
        .environmentObject(object)
//        .onReceive(NotificationCenter.default.publisher(
//            for: UIApplication.willResignActiveNotification
//        )) { _ in
//            let list = model.qrInfoList()
//            if list.count != qrcodeList.count {
//                qrcodeList = model.qrInfoList()
//            }
//        }
//        .onAppear() {
//            reloadData()
//        }
    }
    
    func removeItem(offsets: IndexSet) {
        offsets.forEach { index in
            let deleteItem = object.qrcodeList[index]
            if model.remove(item: deleteItem) {
                object.qrcodeList.remove(at: index)
                app.logEventCount(itemID: .EditCode, ItemName: "Delete")
            }
        }
    }
    
//    func reloadData() {
//        qrcodeList = model.qrInfoList()
//    }
}

struct QRCodeInfoList_Previews: PreviewProvider {
    static var previews: some View {
        let model = QRInfoList()
        ContentView(qecodeList: model)
    }
}
