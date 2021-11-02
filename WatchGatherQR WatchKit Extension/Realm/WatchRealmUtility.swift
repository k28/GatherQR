//
//  WatchRealmUtility.swift
//  WatchGatherQR WatchKit Extension
//
//  Created by K.Hatano on 2021/11/02.
//

import Foundation
import RealmSwift


enum WatchRealmUtility {
}

extension WatchRealmUtility {
    
    static func defaultRealm() -> Realm {
        /// Realmのスキーマバージョンを指定する
        let schemaVersion: UInt64 = 0
        
        let configration = Realm.Configuration(schemaVersion: schemaVersion)
        return try! Realm(configuration: configration)
    }
    
}
