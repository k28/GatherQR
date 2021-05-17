//
//  RegisterQRCodeViewModel.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/16.
//

import UIKit

class RegisterQRCodeViewModel: ObservableObject {
    
    var qrCode: String = ""
    var title: String = ""
    var createDate = Date()
        
    init(qrCode: String) {
        self.qrCode = qrCode
        self.createDate = Date()
    }
    
    func qrCodeImage() -> UIImage {
        return QRCodeUtility.makeQRCode(qrCode) ?? UIImage(systemName: "star.fill")!
    }
    
    func registerQRCode() {
        // TODO QRCode情報を保存するコード
        #if targetEnvironment(simulator)
        #else
        QRInfoEntity.upsert(uuid: UUID().uuidString, title: title, value: qrCode)
        #endif
    }
}
