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
                    print("Button Pushed!!")
                    editButtonDidSelect = true
                }
            
            NavigationLink(destination: RegisterQRCodeView(viewModel: RegisterQRCodeViewModel(info: item.qrInfoModel, onUpdate: { model in
                item.title = model.title
            } ), mode: .Edit),
                           isActive: $editButtonDidSelect) {
                EmptyView()
            }
            .frame(width: 0, height: 0)
            .opacity(0.0)
            .buttonStyle(PlainButtonStyle())
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
