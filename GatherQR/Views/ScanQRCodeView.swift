//
//  ScanQRCodeView.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/15.
//

import SwiftUI

struct ScanQRCodeView: View {
    
    enum Mode {
        case Add
        case Edit
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel = ScannerViewModel()
    let qrCodeScannerView = QRCodeScannerView()
    let mode: Mode
    var registerQRCodeViewModel: RegisterQRCodeViewModel
    
    var body: some View {
        ZStack {
            // Link
            NavigationLink(
                destination: RegisterQRCodeView(viewModel: self.registerQRCodeViewModel, mode: .Add),
                isActive: $viewModel.qrCodeFound) {
                    EmptyView()
                }
            
            // View Contents
            qrCodeScannerView
                .found(r: self.onFoundQRCode(_:))
                .onTorchLight(isOn: self.viewModel.torchIsOn)
                .interval(delay: self.viewModel.scanInterval)
                .onAppear() {
                    onViewAppeard()
                }
                .onDisappear() {
                    onViewDisappeard()
                }
                .onRotate { orientation in
                    qrCodeScannerView.rotationChange(orientation)
                }
            
            VStack {
                VStack {
                    Text(app.loadString("Keep scanning for QR-codes"))
                        .font(.subheadline)
                    Text("")
                        .bold()
                        .lineLimit(5)
                        .padding()
                }
                .padding(.vertical, 20)
                
                Spacer()
                
                HStack {
                    Button(action: {
                        self.viewModel.torchIsOn.toggle()
                    }, label: {
                        Image(systemName: self.viewModel.torchIsOn ? "bolt.fill" : "bolt.slash.fill")
                            .imageScale(.large)
                            .foregroundColor(self.viewModel.torchIsOn ? Color.yellow : Color.blue)
                            .padding()
                    })
                }
                .background(Color.white)
                .cornerRadius(10)
            }.padding()

            .navigationTitle(navigationTitle())
        }

    }
    
    func onViewDisappeard() {
        qrCodeScannerView.stopCameraRunning()
    }
    
    func onViewAppeard() {
        qrCodeScannerView.startCameraRunning()
    }
    
    private func navigationTitle() -> String {
        switch mode {
        case .Add:
            return app.loadString("Add QR Code")
        case .Edit:
            return app.loadString("Rescan QR Code")
        }
    }
    
    /// QRコードが見つかった時にCallされます
    private func onFoundQRCode(_ s: String) {
        self.registerQRCodeViewModel.qrCode = s
        
        switch mode {
        case .Add:
            self.viewModel.onFoundQRCode(s)
        case .Edit:
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
}

struct ScanQRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ScanQRCodeView(mode: .Add, registerQRCodeViewModel: RegisterQRCodeViewModel(qrCode: ""))
    }
}
