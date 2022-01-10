//
//  RegisterQRCodeViewModel.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/16.
//

import UIKit

class RegisterQRCodeViewModel: ObservableObject {
    
    var qrCode: String = ""
    var title: String = "" {
        didSet {
            validate()
        }
    }
    var createDate = Date()
    var uuid = UUID().uuidString
    var info: QRInfoModelProtocol? = nil
    
    var onUpdateModel: ((_ model: RegisterQRCodeViewModel) -> Void) = { _ in }
    
    @Published var isEnableSave: Bool = false
        
    init(qrCode: String) {
        self.qrCode = qrCode
        self.createDate = Date()
    }
    
    init(info: QRInfoModelProtocol, onUpdate: @escaping ((_ model: RegisterQRCodeViewModel) -> Void)) {
        updateInfo(info)
        self.onUpdateModel = onUpdate
    }
    
    func updateInfo(_ info: QRInfoModelProtocol) {
        self.qrCode = info.value
        self.title = info.title
        self.uuid = info.uuid
        self.createDate = info.createDate
        self.info = info
    }
    
    func validate() {
        isEnableSave = false
        if title.isEmpty { return }
        
        isEnableSave = true
    }
    
    func qrCodeImage() -> UIImage {
        return QRCodeUtility.makeQRCode(qrCode) ?? UIImage(systemName: "star.fill")!
    }
    
    func registerQRCode() {
        // TODO QRCode情報を保存するコード
        #if targetEnvironment(simulator)
        #else
        QRInfoEntity.upsert(uuid: uuid, title: title, value: qrCode)
        #endif
        
        onUpdateModel(self)
    }
}
