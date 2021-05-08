//
//  QRCodeUtility.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/08.
//

import Foundation
import SwiftUI

enum QRCodeUtility {}

extension QRCodeUtility {
    
    static func makeQRCode(_ value: String) -> UIImage? {
        let data = value.data(using: String.Encoding.utf8)
        
        guard let fileter = CIFilter(name: "CIQRCodeGenerator") else {
            return nil
        }
        
        fileter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        
        guard let output = fileter.outputImage?.transformed(by: transform) else {
            return nil
        }
        
        let tmpImage = UIImage(ciImage: output)
        
        // UIImageそのままだとImageにした時に表示できないのでPINGを経由する
        guard let pngData = tmpImage.pngData() else {
            return nil
        }
        
        return UIImage(data: pngData)
    }
    
}
