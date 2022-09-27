//
//  RegisterQRCodeView.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/16.
//

import SwiftUI

/// QRコード登録・編集画面
struct RegisterQRCodeView: View {
    
    @EnvironmentObject var object: ObservedInfo
    
    enum Mode {
        case Add
        case Edit
        
        var title: String {
            switch self {
            case .Add:  return app.loadString("Register QR code")
            case .Edit: return app.loadString("Edit")
            }
        }
        
        var itemName: String {
            switch self {
            case .Add:
                return "Add"
            case .Edit:
                return "Edit"
            }
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: RegisterQRCodeViewModel
    let mode: Mode
    let maxImageSize: CGFloat = 250
    @State private var showingScanView = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // QRコードをスキャンして登録する画面
                if #available(iOS 16, *) {
                    NavigationLink(destination: CameraScannerViewController(mode: .Edit, onQRCodeFound: {qrCode in self.onQRCodeUpdate(qrCode) }), isActive: $showingScanView) {
                        EmptyView()
                    }
                } else {
                    NavigationLink(destination: ScanQRCodeView(mode: .Edit, registerQRCodeViewModel: self.viewModel), isActive: $showingScanView) {
                        EmptyView()
                    }
                }
                Form {
                    Section {
                        TextField(app.loadString("Please input the Title"), text: $viewModel.title)
                            .accessibility(identifier: "registerqrcodeview_title_text_field")
                    }
                    
                    Section {
                        HStack {
                            Spacer()
                            Image(uiImage: viewModel.qrCodeImage())
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                    .frame(width: min(maxImageSize, geometry.size.width), height: min(maxImageSize, geometry.size.height), alignment: .center)
                            Spacer()
                        }
                        Text(viewModel.qrCode)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        if mode == .Edit {
                            Button(action: {
                                self.showingScanView = true
                            }) {
                                HStack {
                                    Spacer()
                                    HStack {
                                        Image(systemName: "qrcode.viewfinder")
                                            .resizable()
                                            .frame(width: 24, height: 24, alignment: .center)
                                        Text("Rescan")
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                    Section {
                        Button(action: {
                            viewModel.registerQRCode()
                            if mode == .Add {
                                object.reloadData()
                            }
                            app.logSelectContent(contentType: .edit_code)
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Spacer()
                                Text(app.loadString("Register"))
                                Spacer()
                            }
                        }
                        .disabled(viewModel.isEnableSave == false)
                        .accessibility(identifier: "registerqrcodeview_register_button")
                    }
                }
            }
        }
        .navigationTitle(mode.title)
    }
    
    private func onQRCodeUpdate(_ qrCode: String) {
        viewModel.qrCode = qrCode
        self.showingScanView = false
    }
}

struct RegisterQRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterQRCodeView(viewModel: RegisterQRCodeViewModel(qrCode: "TestQRcode"), mode: .Edit)
    }
}
