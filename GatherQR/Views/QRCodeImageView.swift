//
//  QRCodeImageView.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/08/13.
//

import SwiftUI

/// QRコードのイメージを表示するView
struct QRCodeImageView: View {
    /// QRコードイメージ
    let image: UIImage
    
    /// Viewの最大, 最小サイズ
    let viewSize: CGSize
    
    /// 最大のQRコードサイズ
    let maxImageSize: CGFloat = 250

    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: min(maxImageSize, viewSize.width), height: min(maxImageSize, viewSize.height), alignment: .center)
        }
        .position(x: viewSize.width / 2, y: viewSize.height / 2)
    }
}

struct QRCodeImageView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            QRCodeImageView(image: QRInfoModel().qrcode(), viewSize: geometry.size)
        }
    }
}
