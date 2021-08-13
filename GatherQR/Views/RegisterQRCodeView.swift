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
    }
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: RegisterQRCodeViewModel
    let mode: Mode
    let maxImageSize: CGFloat = 250
    
    var body: some View {
        GeometryReader { geometry in
            Form {
                Section {
                    TextField(app.loadString("Please input the Title"), text: $viewModel.title)
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
                }
                
                Section {
                    Button(action: {
                        viewModel.registerQRCode()
                        if mode == .Add {
                            object.reloadData()
                        }
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Spacer()
                            Text(app.loadString("Register"))
                            Spacer()
                        }
                    }
                    .disabled(viewModel.isEnableSave == false)
                }
            }
        }
        .navigationTitle(mode.title)
    }
}

struct RegisterQRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterQRCodeView(viewModel: RegisterQRCodeViewModel(qrCode: "TestQRcode"), mode: .Add)
    }
}
