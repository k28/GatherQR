//
//  WatchAppCommon.swift
//  WatchGatherQR WatchKit Extension
//
//  Created by K.Hatano on 2021/11/02.
//

import Foundation
import RealmSwift

/// Watchアプリの共通クラス
class WatchAppCommon {
    
    var phoneSyncManager = PhoneSyncManager()
    let watchQRInfoList = WatchQRInfoList()
    
    func initalize() {
        // Setup Phone Sync Manager
        let phoneConnector = PhoneConnector(delegate: phoneSyncManager)
        phoneSyncManager.phoneConnector = phoneConnector
    }
    
    func syncWithPhone() {
        // print("syncWithPhone start")
        phoneSyncManager.syncList()
    }
    
    func onMainThread(_ task: @escaping (() -> Void)) {
        if Thread.isMainThread {
            task()
            return
        }
        DispatchQueue.main.async {
            task()
        }
    }
    
    /// ローカライズ文字列を読み込みます
    /// - Parameter key: Localize ID
    /// - Returns: Localized strings
    func loadString(_ key: String) -> String {
        let str = NSLocalizedString(key, comment: "")
        if str == key {
            // TODO localize log
        }
        
        return str
    }
    
}
