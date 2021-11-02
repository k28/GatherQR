//
//  GetListResponse.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/11/02.
//

import Foundation

/// GetListのレスポンス
struct GetListResponse: Message {
    
    var qrcodelist: QRInfoListProtocol
    
    var kind: String {
        return MessageKind.GetListResponse.rawValue
    }
    
    var data: [String : Any] {
        var dataDict = [String : Any]()
        
        var qrCodeList = [Any]()
        for info in qrcodelist.qrInfoList() {
            var infoDict = [String : Any]()
            infoDict["uuid"] = info.uuid
            infoDict["lastupdate"] = info.lastUpdate
            qrCodeList.append(infoDict)
        }
        dataDict["qrcode_list"] = qrCodeList
        
        return dataDict
    }
    
}
