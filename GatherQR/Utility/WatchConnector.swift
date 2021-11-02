//
//  WatchConnector.swift
//  GatherQR
//
//  Created by K.Hatano on 2021/11/01.
//

import Foundation
import WatchConnectivity

/// WatchConnectorのDelegate
protocol WatchConnectorDelegate {
    
    func onReceiveMessage(_ message: [String : Any])
    
}

class WatchConnector: NSObject, WCSessionDelegate {
    
    var delegate : WatchConnectorDelegate?
    
    init(delegate: WatchConnectorDelegate) {
        super.init()
        self.delegate = delegate
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidCompleteWith state=\(activationState.rawValue)")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("sessionDidBecomeInactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("sessionDidDeactivate")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("didRecieveMessage \(message)")
        delegate?.onReceiveMessage(message)
    }
    
    func sendMessage(message: [String : Any]) {
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(message, replyHandler: nil) { error in
                print("sendMessage error \(error)")
            }
        }
    }
    
}
