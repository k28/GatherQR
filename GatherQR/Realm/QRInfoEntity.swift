//
//  QRInfoEntity.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/08.
//

import Foundation
import RealmSwift
import UIKit

class QRInfoEntity: Object {
    @objc dynamic var uuid: String = UUID().uuidString
    @objc dynamic var order: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var value: String = ""
    @objc dynamic var createDate: Date = Date()
    @objc dynamic var lastUpdate: Date = Date()
}

extension QRInfoEntity {
    
    static func make(value: String) -> QRInfoEntity {
        let entiry = QRInfoEntity()
        entiry.createDate = Date()
        entiry.value = value
        
        return entiry
    }
    
    /// 指定された項目を削除する
    static func remove(uuid: String) -> Bool {
        let realm = RealmUtility.defaultRealm()
        let deleteItem = realm.objects(QRInfoEntity.self).filter("uuid == %@", uuid)
        print("deleteItem.count = \(deleteItem.count)")
        if deleteItem.count == 0 {
            return false
        }
        
        try? realm.write {
            realm.delete(deleteItem)
        }
        
        return true
    }
    
    static func upsert(uuid: String, title: String, value: String) {
        let realm = RealmUtility.defaultRealm()
        if let entity = realm.objects(QRInfoEntity.self).filter(#"uuid = '\#(uuid)'"#).first {
            try? realm.write {
                entity.title = title
                entity.value = value
                entity.lastUpdate = Date()
            }
        } else {
            let entity = make(value: value)
            entity.uuid = uuid
            entity.title = title
            entity.lastUpdate = Date()
            try? realm.write {
                realm.add(entity)
            }
        }
    }
}

extension QRInfoEntity: QRInfoModelProtocol {
    func save() {
        // TODO Code here...
    }
    
    func qrcode() -> UIImage {
        return QRCodeUtility.makeQRCode(value) ?? UIImage(systemName: "star.fill")!
    }
    
}
