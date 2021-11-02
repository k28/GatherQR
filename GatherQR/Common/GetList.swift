//
//  GetList.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/11/02.
//

import Foundation

/// List取得要求
struct GetList: Message {
    var kind: String {
        return MessageKind.GetList.rawValue
    }
    
    var data: [String : Any] {
        return [:]
    }
    
}
