//
//  QRInfoList.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/09.
//

import Foundation

protocol QRInfoListProtocol {
    func qrInfoList() -> [QRInfoModelProtocol]
}

struct QRInfoList: QRInfoListProtocol {

    func qrInfoList() -> [QRInfoModelProtocol] {
        return [
            QRInfoModel(id: 0, title: "first", value: "Apple"),
            QRInfoModel(id: 1, title: "second", value: "Orange"),
        ]
    }

}
