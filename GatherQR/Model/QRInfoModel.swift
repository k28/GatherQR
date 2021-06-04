//
//  QRInfoModel.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/08.
//

import Foundation
import SwiftUI

protocol QRInfoModelProtocol {
    var uuid: String { get }
    var title: String { get set }
    var value: String { get set }
    var createDate: Date { get }
    
    func save()
    func qrcode() -> UIImage
}

extension QRInfoModelProtocol {
    func createDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: createDate)
    }
}

struct QRInfoModel: QRInfoModelProtocol {
    var uuid: String = UUID().uuidString
    var title: String = "Sample Code"
    var value: String = "Hello World"
    var createDate: Date = Date()
    
    func save() {
        // TODO SaveCodeHere..
    }
    
    func qrcode() -> UIImage {        
        return QRCodeUtility.makeQRCode(value) ?? UIImage(systemName: "star.fill")!
    }
}
