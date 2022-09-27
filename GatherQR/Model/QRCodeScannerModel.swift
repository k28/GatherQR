//
//  QRCodeScannerModel.swift
//  GatherQR
//
//  Created by K.Hatano on 2022/09/24.
//

import VisionKit

@available(iOS 16.0, *)
final class QRCodeScannerModel: NSObject, ObservableObject {

    @MainActor func getDataScannerViewController() -> DataScannerViewController {
        let vc = DataScannerViewController(recognizedDataTypes: [.barcode(symbologies: [.qr])])
        
        vc.delegate = self
        
        return vc
    }
    
}

@available(iOS 16.0, *)
extension QRCodeScannerModel: DataScannerViewControllerDelegate {
    
}
