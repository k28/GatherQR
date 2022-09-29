//
//  QRCodeScannerView.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/16.
//

import SwiftUI
import UIKit
import AVFoundation

struct QRCodeScannerView: UIViewRepresentable {
    typealias UIViewType = CameraPreview
    fileprivate let delegate = QRCodeCameraDelegate()
    fileprivate let session = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer?

    func makeUIView(context: Context) -> CameraPreview {
        return context.coordinator.makeUIView()
    }

    func updateUIView(_ uiView: CameraPreview, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    

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
    
    func stopCameraRunning() {
        if session.isRunning {
            session.stopRunning()
        }
    }
    
    func startCameraRunning() {
        if !session.isRunning {
            DispatchQueue.main.async {
                session.startRunning()
            }
        }
    }
    
    func rotationChange(_ orientation: UIDeviceOrientation) {
        if let previewLayer = previewLayer {
            if previewLayer.connection?.isVideoOrientationSupported ?? false {
                previewLayer.connection?.videoOrientation = interfaceOrientationToVideoOrientation(orientation: app.interfaceOrientation)
            }
        }
    }
    
    fileprivate func interfaceOrientationToVideoOrientation(orientation: UIInterfaceOrientation) -> AVCaptureVideoOrientation {
        switch orientation {
        case .portrait:           return .portrait
        case .portraitUpsideDown: return .portraitUpsideDown
        case .landscapeLeft:      return .landscapeLeft
        case .landscapeRight:     return .landscapeRight
        default:
            return .portrait
        }
    }
    
    class Coordinator: NSObject {
        var parent: QRCodeScannerView
        init(_ parent: QRCodeScannerView) {
            self.parent = parent
        }
        
        private var supportedBarcodeTypes: [AVMetadataObject.ObjectType] = [.qr]
        private let metadataOutput = AVCaptureMetadataOutput()
        private var cameraView_: CameraPreview?
        
        
        func setupCamera(_ uiView: CameraPreview) {
            if let backCamera = AVCaptureDevice.default(for: .video) {
                if let input = try? AVCaptureDeviceInput(device: backCamera) {
                    parent.session.sessionPreset = .photo
                    
                    if parent.session.canAddInput(input) {
                        parent.session.addInput(input)
                    }
                    if parent.session.canAddOutput(metadataOutput) {
                        parent.session.addOutput(metadataOutput)
                        
                        metadataOutput.metadataObjectTypes = supportedBarcodeTypes
                        metadataOutput.setMetadataObjectsDelegate(parent.delegate, queue: DispatchQueue.main)
                    }
                    parent.previewLayer = AVCaptureVideoPreviewLayer(session: parent.session)
                    if parent.previewLayer!.connection?.isVideoOrientationSupported ?? false {
                        parent.previewLayer!.connection?.videoOrientation = parent.interfaceOrientationToVideoOrientation(orientation: app.interfaceOrientation)
                    }
                    
                    uiView.backgroundColor = .gray
                    parent.previewLayer!.videoGravity = .resizeAspectFill
                    uiView.layer.addSublayer(parent.previewLayer!)
                    uiView.previewLayer = parent.previewLayer!
                    
                    DispatchQueue.main.async {
                        self.parent.session.startRunning()
                    }
                }
            }
        }
        
        func makeUIView() -> QRCodeScannerView.UIViewType {
            // makeUIView was called twice, and the camera was slow to start.
            // Cache CameraPreview and return it thereafter.
            
            if cameraView_ != nil {
                return cameraView_!
            }
            
            let cameraView = CameraPreview(session: parent.session)
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
    }
    
}
