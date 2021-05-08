//
//  QRCodeInfoRow.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/09.
//

import SwiftUI

struct QRCodeInfoRow: View {
    var item: QRInfoModelProtocol
    
    var body: some View {
        HStack {
            Text(item.title)
        }
    }
}

struct QRCodeInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            QRCodeInfoRow(item: QRInfoModel())
        }
        .previewLayout(.fixed(width: 300, height: 70))

    }
}
