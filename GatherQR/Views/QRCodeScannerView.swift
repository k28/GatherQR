//
//  QRCodeScannerView.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/16.
//

import SwiftUI
import UIKit
import AVFoundation

final class QRCodeScannerView: UIViewRepresentable {
    
    var supportedBarcodeTypes: [AVMetadataObject.ObjectType] = [.qr]
    typealias UIViewType = CameraPreview
    
    private let session = AVCaptureSession()
    private let delegate = QRCodeCameraDelegate()
    private let metadataOutput = AVCaptureMetadataOutput()
    private var cameraView_: CameraPreview?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    
    func onTorchLight(isOn: Bool) -> QRCodeScannerView {
        if let backCamera = AVCaptureDevice.default(for: .video) {
            if backCamera.hasTorch {
                try? backCamera.lockForConfiguration()
                if isOn {
                    backCamera.torchMode = .on
                } else {
                    backCamera.torchMode = .off
                }
                backCamera.unlockForConfiguration()
            }
        }
        return self
    }
    
    func interval(delay: Double) -> QRCodeScannerView {
        delegate.scanInterval = delay
        return self
    }
    
    func found(r: @escaping (String) -> Void) -> QRCodeScannerView {
        delegate.onResult = r
        return self
    }
    
    func simulator(mockBarCode: String) -> QRCodeScannerView {
        delegate.mockData = mockBarCode
        return self
    }
    
    func setupCamera(_ uiView: CameraPreview) {
        if let backCamera = AVCaptureDevice.default(for: .video) {
            if let input = try? AVCaptureDeviceInput(device: backCamera) {
                session.sessionPreset = .photo
                
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                if session.canAddOutput(metadataOutput) {
                    session.addOutput(metadataOutput)
                    
                    metadataOutput.metadataObjectTypes = supportedBarcodeTypes
                    metadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
                }
                previewLayer = AVCaptureVideoPreviewLayer(session: session)
                if previewLayer!.connection?.isVideoOrientationSupported ?? false {
                    previewLayer!.connection?.videoOrientation = interfaceOrientationToVideoOrientation(orientation: app.interfaceOrientation)
                }
                
                uiView.backgroundColor = .gray
                previewLayer!.videoGravity = .resizeAspectFill
                uiView.layer.addSublayer(previewLayer!)
                uiView.previewLayer = previewLayer!
                
                session.startRunning()
            }
        }
    }
    
    func makeUIView(context: UIViewRepresentableContext<QRCodeScannerView>) -> QRCodeScannerView.UIViewType {
        // makeUIView was called twice, and the camera was slow to start.
        // Cache CameraPreview and return it thereafter.
        
        if cameraView_ != nil {
            return cameraView_!
        }
        
        let cameraView = CameraPreview(session: session)
        cameraView_ = cameraView
        
        #if targetEnvironment(simulator)
        cameraView.createSimulatorView(delegate: self.delegate)
        #else
        checkCameraAuthorizationStatus(cameraView)
        #endif
        
        return cameraView
    }

    func checkCameraAuthorizationStatus(_ uiView: CameraPreview) {
        let cameraAuthorizationStats = AVCaptureDevice.authorizationStatus(for: .video)
        if cameraAuthorizationStats == .authorized {
            setupCamera(uiView)
        } else {
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.sync {
                    if granted {
                        self.setupCamera(uiView)
                    }
                }
            }
        }
    }
    
    private func interfaceOrientationToVideoOrientation(orientation: UIInterfaceOrientation) -> AVCaptureVideoOrientation {
        switch orientation {
        case .portrait:           return .portrait
        case .portraitUpsideDown: return .portraitUpsideDown
        case .landscapeLeft:      return .landscapeLeft
        case .landscapeRight:     return .landscapeRight
        default:
            return .portrait
        }
    }
    
    func rotationChange(_ orientation: UIDeviceOrientation) {
        if let previewLayer = previewLayer {
            if previewLayer.connection?.isVideoOrientationSupported ?? false {
                previewLayer.connection?.videoOrientation = interfaceOrientationToVideoOrientation(orientation: app.interfaceOrientation)
            }
        }
    }

    static func dismantleUIView(_ uiView: CameraPreview, coordinator: ()) {
        uiView.session.stopRunning()
    }
    
    func stopCameraRunning() {
        if session.isRunning {
            session.stopRunning()
        }
    }
    
    func startCameraRunning() {
        if !session.isRunning {
            session.startRunning()
        }
    }
    
    func updateUIView(_ uiView: CameraPreview, context: UIViewRepresentableContext<QRCodeScannerView>) {
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}
