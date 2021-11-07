//
//  AppResult.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/11/02.
//

import Foundation

/// このアプリケーションで扱うエラー
enum AppResult: Error {
    
    case Error(message: String, code: Int)
    
}
