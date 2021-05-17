//
//  RegisterQRCodeView.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/16.
//

import SwiftUI

/// QRコード登録・編集画面
struct RegisterQRCodeView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: RegisterQRCodeViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                
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
                        Button(action: { viewModel.registerQRCode() }, label: {
                            Text("追加")
                        })
                    }
                }
                .navigationTitle("QRコードの追加")
            }
        }
    }
}

struct RegisterQRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterQRCodeView(viewModel: RegisterQRCodeViewModel(qrCode: "TestQRcode"))
    }
}
