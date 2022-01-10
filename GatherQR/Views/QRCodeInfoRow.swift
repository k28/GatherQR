//
//  QRCodeInfoRow.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/09.
//

import SwiftUI

struct QRCodeInfoRow: View {
    @ObservedObject var item: QRCodeInfoRowViewModel
    @State var editButtonDidSelect = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.title)
                    .foregroundColor(.primary)
                Text(item.createDateString())
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "pencil.circle")
                .foregroundColor(.gray)
                .onTapGesture {
                    editButtonDidSelect = true
                }
            
            // RegisterQRCodeViewに渡すViewModel. 後で情報を更新する必要があるのでインスタンスを生成して保持しておく。
            let registerQRCodeViewModel = RegisterQRCodeViewModel(info: item.qrInfoModel, onUpdate: { model in
                item.title = model.title
            })
            NavigationLink(destination: RegisterQRCodeView(viewModel: registerQRCodeViewModel, mode: .Edit),
                           isActive: $editButtonDidSelect) {
                EmptyView()
            }
            .frame(width: 0, height: 0)
            .opacity(0.0)
            .buttonStyle(PlainButtonStyle())
            .onAppear(perform: {
                // RegisterQRCodeViewで編集して登録せずに戻った時に編集前の情報に戻すためにregisterQRCodeViewModelを再度設定し直す。
                // 「登録」した時もCallされるが、その時にはitemのqrInfoModelも更新されている状態なので問題ない。
                registerQRCodeViewModel.updateInfo(item.qrInfoModel)
            })
        }
    }
}

struct QRCodeInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            QRCodeInfoRow(item: QRCodeInfoRowViewModel(model: QRInfoModel()))
        }
        .previewLayout(.fixed(width: 300, height: 70))

    }
}
