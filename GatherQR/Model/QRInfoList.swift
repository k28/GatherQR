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
        var list = [QRInfoModelProtocol]()
        for i in 1..<10 {
            list.append(QRInfoModel(id: i, title: "\(i) item", value: "Apple"))
        }
        return list
    }

}
