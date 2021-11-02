//
//  Message.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/11/02.
//

import Foundation

enum MessageKey: String {
    case Kind
    case Data
}

enum MessageKind: String {
    case GetList
    case GetListResponse
    case QRInfoRequest
    case QRInfoResponse
}

protocol Message {
    var kind: String { get }
    var data: [String : Any] { get }
}


extension Message {
    
    func makeMessage() -> [String : Any] {
        return [MessageKey.Kind.rawValue : kind, MessageKey.Data.rawValue : data]
    }
    
}
