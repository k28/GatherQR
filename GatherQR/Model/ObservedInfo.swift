//
//  ObservedInfo.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/08/01.
//

import Foundation

class ObservedInfo: ObservableObject {
    @Published var qrcodeList: [QRInfoModelProtocol] = []
    
    init() {
        reloadData()
    }
    
}

extension ObservedInfo {
    
    func reloadData() {
        qrcodeList = QRInfoList().qrInfoList()
    }
    
}
