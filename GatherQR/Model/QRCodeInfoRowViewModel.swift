//
//  QRCodeInfoRowViewModel.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/07/11.
//

import Foundation

class QRCodeInfoRowViewModel: ObservableObject {

    @Published
    var title: String
    let createDate: Date
    let uuid: String
    
    let qrInfoModel: QRInfoModelProtocol
    
    init(model: QRInfoModelProtocol) {
        title = model.title
        createDate = model.createDate
        uuid = model.uuid
        qrInfoModel = model
    }
    
}

extension QRCodeInfoRowViewModel {

    func createDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: createDate)
    }

}
