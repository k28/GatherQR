//
//  QRInfoResponse.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/11/02.
//

import Foundation
import UIKit

struct QRInfoResponse: Message {
    
    let qrCodeInfoList: [QRInfoModelProtocol]
    
    var kind: String {
        return MessageKind.QRInfoResponse.rawValue
    }
    
    var data: [String : Any] {
        
        var infoList = [Any]()
        for qrCodeInfo in qrCodeInfoList {
            var result = [String : Any]()
            result["uuid"] = qrCodeInfo.uuid
            result["title"] = qrCodeInfo.title
            result["lastupdate"] = qrCodeInfo.lastUpdate
            result["qrcode_data"] = qrCodeInfo.qrcode().pngData() ?? Data()
            
            infoList.append(result)
        }
        
        return ["info" : infoList]
    }
    
    
}
