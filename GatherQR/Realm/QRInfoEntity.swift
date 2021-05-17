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
}

extension QRInfoEntity {
    
    static func make(value: String) -> QRInfoEntity {
        let entiry = QRInfoEntity()
        entiry.createDate = Date()
        entiry.value = value
        
        return entiry
    }
    
    static func upsert(uuid: String, title: String, value: String) {
        
        // TODO upsertできるようにする
        
        let realm = RealmUtility.defaultRealm()
//        if let entity = realm.objects(QRInfoEntity.self).filter("uuid = \(uuid)").first {
//            try? realm.write {
//                entity.title = title
//                entity.value = value
//            }
//        } else {
//            let entity = make(value: value)
//            entity.uuid = uuid
//            entity.title = title
//            try? realm.write {
//                realm.add(entity)
//            }
//        }
        
        let entity = make(value: value)
        entity.uuid = uuid
        entity.title = title
        try? realm.write {
            realm.add(entity)
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
