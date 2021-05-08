//
//  QRInfoModel.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/08.
//

import Foundation
import SwiftUI

protocol QRInfoModelProtocol {
    var title: String { get set }
    var value: String { get set }
    
    func save()
    func qrcode() -> UIImage
}

struct QRInfoModel: QRInfoModelProtocol {
    var title: String = "Sample Code"
    var value: String = "Hello World"
    
    func save() {
        // TODO SaveCodeHere..
    }
    
    func qrcode() -> UIImage {        
        return QRCodeUtility.makeQRCode(value) ?? UIImage(systemName: "star.fill")!
    }
}
