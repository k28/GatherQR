//
//  QRCodeCameraDelegate.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/15.
//

import Foundation
import AVFoundation

class QRCodeCameraDelegate: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    
    var scanInterval: Double = 1.0
    var lastTime = Date(timeIntervalSince1970: 0)
    
    var onResult: (String) -> Void = {_ in }
    var mockData: String? = nil
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            
            foundBarcode(stringValue)
        }
    }
    
    @objc func onSimulateScanning() {
        foundBarcode(mockData ?? "Simulated QR-code result.")
    }
    
    func foundBarcode(_ sringValue: String) {
        let now = Date()
        if now.timeIntervalSince(lastTime) >= scanInterval {
            lastTime = now
            self.onResult(sringValue)
        }
    }
}
