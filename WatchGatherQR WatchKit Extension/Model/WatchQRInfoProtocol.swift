//
//  WatchQRInfoProtocol.swift
//  WatchGatherQR WatchKit Extension
//
//  Created by K.Hatano on 2021/11/02.
//

import Foundation
import UIKit

protocol WatchQRInfoProtocol {
    var uuid: String { get }
    var title: String { get }
    var lastUpdate: Date { get }
    var qrCode: UIImage { get }
}

class WatchQRInfoStb: WatchQRInfoProtocol {
    var uuid: String = ""
    
    var title: String = ""
    
    var lastUpdate: Date = Date()
    
    var qrCode: UIImage {
        return UIImage(systemName: "star.fill")!
    }
    
    static func make(title: String) -> WatchQRInfoStb {
        let model = WatchQRInfoStb()
        model.title = title
        return model
    }
    
}
