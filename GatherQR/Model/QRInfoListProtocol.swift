//
//  QRInfoListProtocol.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/11/02.
//

import Foundation

protocol QRInfoListProtocol {
    func qrInfoList() -> [QRInfoModelProtocol]
    
    /// 指定された項目を削除する
    func remove(item: QRInfoModelProtocol) -> Bool
}
