//
//  WatchQRInfoEntity.swift
//  WatchGatherQR WatchKit Extension
//
//  Created by K.Hatano on 2021/11/02.
//

import Foundation
import RealmSwift
import UIKit

class WatchQRInfoEntity: Object, WatchQRInfoProtocol, NSCopying {
    
    @objc dynamic var uuid: String = UUID().uuidString
    @objc dynamic var order: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var imageData: Data = Data()
    @objc dynamic var lastUpdate: Date = Date()
    
    var qrCode: UIImage {
        guard let imageData = UIImage(data: imageData) else {
            return UIImage(named: "star.fill")!
        }
        
        return imageData
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let entity = WatchQRInfoEntity()
        entity.uuid = self.uuid
        entity.order = self.order
        entity.title = self.title
        entity.imageData = self.imageData
        entity.lastUpdate = self.lastUpdate
        return entity
    }
}

extension WatchQRInfoEntity {
    
    static func make(uuid: String) -> WatchQRInfoEntity {
        let entity = WatchQRInfoEntity()
        entity.uuid = uuid
        return entity
    }
    
    static func upsert(info: [String : Any]) throws {
        guard let uuid = info["uuid"] as? String else {
            throw AppResult.Error(message: "WatchQRInfoEntity.upsert", code: 9999)
        }
        
        let realm = WatchRealmUtility.defaultRealm()
        if let entity = realm.objects(WatchQRInfoEntity.self).filter(#"uuid = '\#(uuid)'"#).first {
            try? realm.write {
                try entity.update(info: info)
            }
        } else {
            let entity = make(uuid: uuid)
            try entity.update(info: info)
            try? realm.write {
                realm.add(entity)
            }
        }
    }
    
    static func delete(uuid: String) {
        let realm = WatchRealmUtility.defaultRealm()
        let deleteItem = realm.objects(WatchQRInfoEntity.self).filter("uuid == %@", uuid)
        if deleteItem.isEmpty {
            return
        }
        try? realm.write {
            realm.delete(deleteItem)
        }
    }
    
    func update(info: [String : Any]) throws {
        guard let title = info["title"] as? String else {
            throw AppResult.Error(message: "WatchQRInfoEntity.update", code: 9999)
        }
        guard let lastupdate = info["lastupdate"] as? Date else {
            throw AppResult.Error(message: "WatchQRInfoEntity.update", code: 9998)
            
        }
        guard let imageData = info["qrcode_data"] as? Data else {
            throw AppResult.Error(message: "WatchQRInfoEntity.update", code: 9997)
            
        }
        
        self.title = title
        self.lastUpdate = lastupdate
        self.imageData = imageData
    }
    
}
