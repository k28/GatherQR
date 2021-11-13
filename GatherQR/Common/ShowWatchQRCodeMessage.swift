//
//  ShowWatchQRCodeMessage.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/11/13.
//

import Foundation

struct ShowWatchQRCodeMessage: Message {
    
    var kind: String = MessageKind.ShowWatchQRCode.rawValue
    
    var data: [String : Any] {
        return [:]
    }
    
}
