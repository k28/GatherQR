//
//  App.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/08/01.
//

import UIKit

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
    
}
