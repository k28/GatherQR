//
//  CameraScannerViewController.swift
//  GatherQR
//
//  Created by K.Hatano on 2022/09/26.
//

import SwiftUI
import UIKit
import VisionKit

/// VisionKitを使って、QRコードを読み込むView
@available(iOS 16.0, *)
struct CameraScannerViewController: UIViewControllerRepresentable {
    
    enum Mode {
        case Add
        case Edit
    }
    
    @Environment(\.presentationMode) var presentation
    let mode: Mode
    var startScanning: Bool = true
    var onQRCodeFound: ((_ qrCode: String) -> Void)
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    @MainActor
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let viewController = DataScannerViewController(
            recognizedDataTypes: [.barcode(symbologies: [.qr])],
            qualityLevel: .balanced,
            recognizesMultipleItems: false,
            isHighFrameRateTrackingEnabled: false,
            isHighlightingEnabled: true
        )
        
        viewController.delegate = context.coordinator
        
        return viewController
    }
    
    @MainActor
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        if startScanning {
            try? uiViewController.startScanning()
        } else {
            uiViewController.stopScanning()
        }
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: CameraScannerViewController
        init(_ parent: CameraScannerViewController) {
            self.parent = parent
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            switch addedItems.last {
            case .barcode(let code):
                if let payloadStringValue = code.payloadStringValue {
                    parent.onQRCodeFound(payloadStringValue)
                    if parent.mode == .Edit {
                        parent.presentation.wrappedValue.dismiss()
                    }
                }
                break
            default:
                break
            }
        }
    }
    
    @MainActor static func isSupported() -> Bool {
        return DataScannerViewController.isSupported && DataScannerViewController.isAvailable
    }
    
}
