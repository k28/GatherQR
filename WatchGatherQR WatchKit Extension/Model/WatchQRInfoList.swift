//
//  WatchQRInfoList.swift
//  WatchGatherQR WatchKit Extension
//
//  Created by K.Hatano on 2021/11/02.
//

import Foundation
import SwiftUI

class WatchQRInfoList: ObservableObject {
    
    @Published var qrInfoList: [WatchQRInfoProtocol] = []
    
    init () {
        loadFromDB()
    }
    
    func info(for uuid: String) -> WatchQRInfoProtocol? {
        return qrInfoList.first(where: { $0.uuid == uuid })
    }
    
}

extension WatchQRInfoList {
    
    func loadFromDB() {
        qrInfoList.removeAll()
        
        #if targetEnvironment(simulator)
        qrInfoList.append(WatchQRInfoStb.make(title: "Test 1"))
        qrInfoList.append(WatchQRInfoStb.make(title: "Test 2"))
        #else
        let result = WatchRealmUtility.defaultRealm().objects(WatchQRInfoEntity.self)
        for i in 0..<result.count {
            let item = result[i]
            if item.isInvalidated {
                continue
            }
            qrInfoList.append(item.copy() as! WatchQRInfoProtocol)
        }
        #endif
    }
    
    func reload() {
        loadFromDB()
    }
    
    func needUpdate(uuid: String, lastUpdate: Date) -> Bool {
        guard let info = info(for: uuid) else {
            return true
        }
        
        return (info.lastUpdate != lastUpdate)
    }
    
    func deleteItems(uuids: [String]) {
        for uuid in uuids {
            qrInfoList.removeAll(where: {$0.uuid == uuid})
            WatchQRInfoEntity.delete(uuid: uuid)
        }
        reload()
    }
    
    var uuidList: [String] {
        var ids: [String] = []
        for item in qrInfoList {
            ids.append(item.uuid)
        }
        return ids
    }
    
}
