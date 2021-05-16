//
//  ScannerViewModel.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/15.
//

import Foundation

class ScannerViewModel: ObservableObject {
    
    /// Defines how offten we are goint to try looking for a new QR-code in the camera frame
    let scanInterval: Double = 1.0
    
    @Published var touchIsOn = false
    @Published var lastQRCode: String = "Qr-code goes here..."
    
    func onFoundQRCode(_ code: String) {
        self.lastQRCode = code
        
        NSLog("kitakita \(code)")
    }
    
}
