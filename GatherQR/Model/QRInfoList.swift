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
        
        #if targetEnvironment(simulator)
        var list = [QRInfoModelProtocol]()
        for i in 1..<10 {
            list.append(QRInfoModel(title: "\(i) item", value: "Apple"))
        }
        return list
        #else
        return loadFromDB()
        #endif
    }
    
    // Realmからデータを読み込んで表示する
    func loadFromDB() -> [QRInfoModelProtocol] {
        var list = [QRInfoModelProtocol]()
        let result = RealmUtility.defaultRealm().objects(QRInfoEntity.self)
        
        for i in 0..<result.count {
            let item = result[i]
            list.append(item)
        }

        return list
    }

}
