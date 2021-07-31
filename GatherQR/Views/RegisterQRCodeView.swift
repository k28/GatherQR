//
//  RegisterQRCodeView.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/16.
//

import SwiftUI

/// QRコード登録・編集画面
struct RegisterQRCodeView: View {
    
    enum Mode {
        case Add
        case Edit
        
        var title: String {
            switch self {
            case .Add:  return "QRコードの登録"
            case .Edit: return "編集"
            }
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: RegisterQRCodeViewModel
    let mode: Mode
    
    var body: some View {
        Form {
            Section {
                TextField("タイトルを入力してください。", text: $viewModel.title)
            }
            
            Section {
                Image(uiImage: viewModel.qrCodeImage())
                    .resizable()
                    .scaledToFit()
            }
            
            Section {
                Button(action: {
                    viewModel.registerQRCode()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Spacer()
                        Text("登録")
                        Spacer()
                    }
                }
                .disabled(viewModel.isEnableSave == false)
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
