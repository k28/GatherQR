//
//  App.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/08/01.
//

import UIKit
import FirebaseAnalytics

enum AnalyticsItemID: String {
    case ShowCode
    case EditCode
}

/**
 アプリケーション共通のユーティリティクラス
 */
class AppCommon {
    
    func initialize() {
    }
}

extension AppCommon {

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
    
    /// FireBaseのAnalyticsを追加します。
    /// - Parameters:
    ///   - itemID: ItemのID
    ///   - ItemName: Itemの名称
    func logEventCount(itemID: AnalyticsItemID, ItemName: String) {
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-\(itemID.rawValue)",
          AnalyticsParameterItemName: ItemName,
          AnalyticsParameterContentType: "cont",
        ])
    }
    
}
