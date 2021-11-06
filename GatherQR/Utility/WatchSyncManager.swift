//
//  WatchSyncManager.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/11/02.
//

import Foundation

class WatchSyncManager: WatchConnectorDelegate {
    
    var watchConnector: WatchConnector!
    
    func onReceiveMessage(_ message: [String : Any]) {
        // print("onReceiveMessage \(message)")
        guard let kind = message[MessageKey.Kind.rawValue] as? String else {
            print("Unknown kind")
            return
        }
        // print("onReceiveMessage kind=\(kind)")
        
        switch kind {
        case MessageKind.GetList.rawValue:
            let getListResponse = GetListResponse(qrcodelist: QRInfoList())
            let message = getListResponse.makeMessage()
            // print("response message =\(message)")
            watchConnector.sendMessage(message: message)
            break
        case MessageKind.QRInfoRequest.rawValue:
            guard let data = message[MessageKey.Data.rawValue] as? [String : Any] else {
                return
            }
            qrInfoRequest(data)
            break
        default:
            break
        }
    }
    
    func qrInfoRequest(_ data: [String : Any]) {
        guard let uuidList = data["uuidlist"] as? [String] else {
            // print("uuidList is not support type or nil")
            return
        }
        
        let qrInfoList = QRInfoList()
        let filterdList = qrInfoList.qrInfoList().filter({ uuidList.contains($0.uuid) })
        if filterdList.count == 0 {
            return
        }
        
        for i in filterdList {
            // print("send qrcode info \(i.uuid)")
            let response = QRInfoResponse(qrCodeInfoList: [i])
            watchConnector.sendMessage(message: response.makeMessage())
        }
    }
    
}
