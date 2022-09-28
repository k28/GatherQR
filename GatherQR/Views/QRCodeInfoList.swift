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
    @State var resisterQRCode = ""
//    @State var qrcodeList: [QRInfoModelProtocol] = []
    @State private var showingScanView = false
    @State private var showQRCodeRegisterView = false
    @State private var showCameraScannerNotSupportDialog = false

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
                
                if #available(iOS 16, *) {
                    NavigationLink(destination: CameraScannerViewController(mode: .Add, onQRCodeFound: {qrCode in self.onQRCodeFound(qrCode) }), isActive: $showingScanView) {
                        EmptyView()
                    }
                } else {
                    // QRコードをスキャンして登録する画面
                    NavigationLink(destination: ScanQRCodeView(mode: .Add, registerQRCodeViewModel: RegisterQRCodeViewModel(qrCode: "")), isActive: $showingScanView) {
                        EmptyView()
                    }
                }
                
                // iOS16以降の時にQRCodeを登録するための画面遷移
                NavigationLink(destination: RegisterQRCodeView(viewModel: RegisterQRCodeViewModel(qrCode: resisterQRCode), mode: .Add), isActive: $showQRCodeRegisterView) {
                    EmptyView()
                }
                
                // Bottom Add Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            if #available(iOS 16, *) {
                                // VisionKitを使ったDataScannerViewControllerがサポートされていない機器の時にメッセージを表示します
                                showingScanView = CameraScannerViewController.isSupported()
                                showCameraScannerNotSupportDialog = !showingScanView
                            } else {
                                showingScanView = true
                            }
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
                        .accessibility(identifier: "qrcodelist_add_button")
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
        .alert("The camera cannot be activated.", isPresented: $showCameraScannerNotSupportDialog, actions: {}, message: {
            Text(app.loadString("Check if the camera function is enabled and if the device is VisionKit enabled."))
        })
    }
    
    func removeItem(offsets: IndexSet) {
        offsets.forEach { index in
            let deleteItem = object.qrcodeList[index]
            if model.remove(item: deleteItem) {
                object.qrcodeList.remove(at: index)
                app.logSelectContent(contentType: .delete_code)
            }
        }
    }
    
    fileprivate func onQRCodeFound(_ qrCode: String) {
        resisterQRCode = qrCode
        showQRCodeRegisterView = true
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
