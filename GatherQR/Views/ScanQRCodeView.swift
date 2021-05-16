//
//  ScanQRCodeView.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/15.
//

import SwiftUI

struct ScanQRCodeView: View {
    @ObservedObject var viewModel = ScannerViewModel()
    
    var body: some View {
        ZStack {
            QRCodeScannerView()
                .found(r: self.viewModel.onFoundQRCode(_:))
                .onTorchLight(isOn: self.viewModel.touchIsOn)
                .interval(delay: self.viewModel.scanInterval)
            
            VStack {
                VStack {
                    Text("Keep scanning for QR-codes")
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
                        Image(systemName: self.viewModel.touchIsOn ? "bolt.fill" : "bolt.slash.fill")
                            .imageScale(.large)
                            .foregroundColor(self.viewModel.touchIsOn ? Color.yellow : Color.blue)
                            .padding()
                    })
                }
                .background(Color.white)
                .cornerRadius(10)
            }.padding()
        }
    }
}

struct ScanQRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ScanQRCodeView()
    }
}
