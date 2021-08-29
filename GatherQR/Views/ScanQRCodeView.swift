//
//  ScanQRCodeView.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/15.
//

import SwiftUI

struct ScanQRCodeView: View {
    @ObservedObject var viewModel = ScannerViewModel()
    let qrCodeScannerView = QRCodeScannerView()
    
    var body: some View {
        ZStack {
            // Link
            NavigationLink(
                destination: RegisterQRCodeView(viewModel: RegisterQRCodeViewModel(qrCode: viewModel.lastQRCode), mode: .Add),
                isActive: $viewModel.qrCodeFound) {
                EmptyView()
            }
            
            // View Contents
            qrCodeScannerView
                .found(r: self.viewModel.onFoundQRCode(_:))
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
                    Text(self.viewModel.lastQRCode)
                        .bold()
                        .lineLimit(5)
                        .padding()
                }
                .padding(.vertical, 20)
                
                Spacer()
                
                HStack {
                    Button(action: {
                        
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

            .navigationTitle(app.loadString("Add QR Code"))
        }

    }
    
    func onViewDisappeard() {
        qrCodeScannerView.stopCameraRunning()
    }
    
    func onViewAppeard() {
        qrCodeScannerView.startCameraRunning()
    }
    
}

struct ScanQRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ScanQRCodeView()
    }
}
