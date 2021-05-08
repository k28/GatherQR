//
//  QRInfoEntity.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/08.
//

import Foundation
import RealmSwift

class QRInfoEntity: Object {
    @objc dynamic var id: Int = 0
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
    
    static func upsert(id: Int, value: String) {
    }
    
}
