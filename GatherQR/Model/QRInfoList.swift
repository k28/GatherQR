//
//  QRInfoList.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/05/09.
//

import Foundation


struct QRInfoList: QRInfoListProtocol {

    #if targetEnvironment(simulator)
    static var tmpList = [QRInfoModelProtocol]();
    #endif
    
    func qrInfoList() -> [QRInfoModelProtocol] {
        
        #if targetEnvironment(simulator)
        if QRInfoList.tmpList.count > 0 {
            return QRInfoList.tmpList
        }
        for i in 1..<10 {
            QRInfoList.tmpList.append(QRInfoModel(title: "\(i) item", value: "Apple"))
        }

        // 日本語版スクリーンショット
//        QRInfoList.tmpList.append(QRInfoModel(title: "保育園 健", value: "Ken"))
//        QRInfoList.tmpList.append(QRInfoModel(title: "保育園 岳", value: "Gaku"))
//        QRInfoList.tmpList.append(QRInfoModel(title: "Home Page", value: "https://gatherqr.web.app/"))
        
        // 英語版スクリーンショット
//        QRInfoList.tmpList.append(QRInfoModel(title: "Access Log", value: "LogLogLog"))
//        QRInfoList.tmpList.append(QRInfoModel(title: "Access Log 2", value: "Log2LogLogLog2"))
//        QRInfoList.tmpList.append(QRInfoModel(title: "Home Page", value: "https://gatherqr.web.app/"))

        return QRInfoList.tmpList
        #else
        return loadFromDB()
        #endif
    }
    
    func remove(item: QRInfoModelProtocol) -> Bool {
        #if targetEnvironment(simulator)
        QRInfoList.tmpList.removeAll(where: {$0.uuid == item.uuid})
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
