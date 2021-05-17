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
        return try! Realm()
    }
}

