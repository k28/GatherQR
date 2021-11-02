//
//  QRInfoList.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/09.
//

import Foundation


struct QRInfoList: QRInfoListProtocol {

    func qrInfoList() -> [QRInfoModelProtocol] {
        
        #if targetEnvironment(simulator)
        var list = [QRInfoModelProtocol]()
        for i in 1..<10 {
            list.append(QRInfoModel(title: "\(i) item", value: "Apple"))
        }

        // 日本語版スクリーンショット
//        list.append(QRInfoModel(title: "保育園 健", value: "Ken"))
//        list.append(QRInfoModel(title: "保育園 岳", value: "Gaku"))
//        list.append(QRInfoModel(title: "Home Page", value: "https://gatherqr.web.app/"))
        
        // 英語版スクリーンショット
//        list.append(QRInfoModel(title: "Access Log", value: "LogLogLog"))
//        list.append(QRInfoModel(title: "Access Log 2", value: "Log2LogLogLog2"))
//        list.append(QRInfoModel(title: "Home Page", value: "https://gatherqr.web.app/"))

        return list
        #else
        return loadFromDB()
        #endif
    }
    
    func remove(item: QRInfoModelProtocol) -> Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return QRInfoEntity.remove(uuid: item.uuid)
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
