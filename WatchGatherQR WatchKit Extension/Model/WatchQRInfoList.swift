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
        
        let result = WatchRealmUtility.defaultRealm().objects(WatchQRInfoEntity.self)
        for i in 0..<result.count {
            let item = result[i]
            qrInfoList.append(item)
        }
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
    
}
