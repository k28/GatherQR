//
//  ScannerViewModel.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/15.
//

import UIKit

class ScannerViewModel: ObservableObject {
    
    /// Defines how offten we are goint to try looking for a new QR-code in the camera frame
    let scanInterval: Double = 1.0
    
    @Published var torchIsOn = false
    @Published var lastQRCode: String = ""
    @Published var qrCodeFound = false
    
    func onFoundQRCode(_ code: String) {
        // 読み込んだQRコードは一旦非表示にする(続けて読み込むときに前のが表示されちゃうので)
        // self.lastQRCode = code
        self.qrCodeFound = true
    }
    
}
