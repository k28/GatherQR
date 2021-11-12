//
//  App.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/08/01.
//

import UIKit
import FirebaseAnalytics

enum AnalyticsSelectContentType: String {
    // case count  => Ver. 1.01までのselect_contentの集計結果
    case show_code
    case show_on_watch
    case edit_code
    case delete_code
}

/**
 アプリケーション共通のユーティリティクラス
 */
class AppCommon {
    
    let watchSyncManager: WatchSyncManager = WatchSyncManager()
    
    func initialize() {
        let watchConnector = WatchConnector(delegate: watchSyncManager)
        self.watchSyncManager.watchConnector = watchConnector
    }
}

extension AppCommon {
    
    var interfaceOrientation: UIInterfaceOrientation {
        if let interfaceOrientation = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.windowScene?.interfaceOrientation {
            return interfaceOrientation
        }
        return .portrait
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
    
    /// FireBaseのAnalyticsを追加します。
    /// - Parameters:
    ///   - itemID: ItemのID
    ///   - ItemName: Itemの名称
    func logSelectContent(contentType: AnalyticsSelectContentType) {
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterContentType: contentType.rawValue,
            // AnalyticsParameterContentType: "count",
        ])
    }
    
}
