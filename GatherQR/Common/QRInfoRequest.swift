//
//  QRInfoRequest.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/11/02.
//

import Foundation

struct QRInfoRequest: Message {
    
    let uuidList: [String]
    
    init (uuidList: [String]) {
        self.uuidList = uuidList
    }
    
    var kind: String {
        return MessageKind.QRInfoRequest.rawValue
    }
    
    var data: [String : Any] {
        return ["uuidlist" : uuidList]
    }
    

}
