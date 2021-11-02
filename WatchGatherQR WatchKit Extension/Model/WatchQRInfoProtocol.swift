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
