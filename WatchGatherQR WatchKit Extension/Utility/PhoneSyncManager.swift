//
//  PhoneSyncManager.swift
//  WatchGatherQR WatchKit Extension
//
//  Created by K.Hatano on 2021/11/02.
//

import Foundation
import CoreAudio

/// PhoneとQRCode情報をSyncする
class PhoneSyncManager: PhoneConnectorDelegate {
    
    var phoneConnector: PhoneConnector!
    
    init() {
    }
    
    func syncList() {
        if phoneConnector.isReachable {
            phoneConnector.send(message: GetList().makeMessage())
        }
    }
    
    func updateList(_ uuidList: [String]) {
        let qrInfoRequest = QRInfoRequest(uuidList: uuidList)
        if phoneConnector.isReachable {
            phoneConnector.send(message: qrInfoRequest.makeMessage())
        }
    }
    
    func onReceiveMessage(_ message: [String : Any]) {
        guard let kind = message[MessageKey.Kind.rawValue] as? String else {
            return
        }
        
        guard let data = message[MessageKey.Data.rawValue] as? [String : Any] else {
            return
        }
        
        switch kind {
        case MessageKind.GetListResponse.rawValue:
            analyzeGetListResponse(data)
        case MessageKind.QRInfoResponse.rawValue:
            analyzeQRInfoResponse(data)
        default:
            break
        }
    }

    /// GetListのレスポンスを解析する
    func analyzeGetListResponse(_ data: [String: Any]) {
        guard let qrcodeList = data["qrcode_list"] as? [Any] else {
            return
        }
        
        var deleteUUIDs = app.watchQRInfoList.uuidList
        var needUpdateList = [String]()
        
        for info in qrcodeList {
            guard let infoDict = info as? [String: Any] else {
                print("analyzeGetListResponse 9998")
                continue
            }
            guard let uuid = infoDict["uuid"] as? String, let lastUpdate = infoDict["lastupdate"] as? Date else {
                print("analyzeGetListResponse 9999")
                continue
            }
            
            if app.watchQRInfoList.needUpdate(uuid: uuid, lastUpdate: lastUpdate) {
                needUpdateList.append(uuid)
            }
            
            deleteUUIDs.removeAll(where: {$0 == uuid})
        }
        
        // 削除されていた項目をリストから削除する
        if !deleteUUIDs.isEmpty {
            app.watchQRInfoList.deleteItems(uuids: deleteUUIDs)
        }
        
        if needUpdateList.count > 0 {
            // Phoneに更新情報を依頼する
            updateList(needUpdateList)
        }
    }
    
    func analyzeQRInfoResponse(_ data: [String: Any]) {
        guard let infoList = data["info"] as? [Any] else {
            return
        }
        
        for info in infoList {
            guard let infoDict = info as? [String : Any] else {
                continue
            }
            do {
                try WatchQRInfoEntity.upsert(info: infoDict)
                app.watchQRInfoList.reload()
            } catch {
               print("analyzeQRInfoResponse error = \(error)")
            }
        }
    }
    
}
