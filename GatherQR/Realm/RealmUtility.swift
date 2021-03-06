//
//  RealmUtility.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/16.
//

import Foundation
import RealmSwift

enum RealmUtility {
}

extension RealmUtility {
    
    static func defaultRealm() -> Realm {
        /// Realmのスキーマバージョンを指定する
        let schemaVersion: UInt64 = 1
        
        let configration = Realm.Configuration(schemaVersion: schemaVersion)
        return try! Realm(configuration: configration)
    }
}

