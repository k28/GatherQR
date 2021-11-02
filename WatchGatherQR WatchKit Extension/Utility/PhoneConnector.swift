//
//  PhoneConnector.swift
//  WatchGatherQR WatchKit Extension
//
//  Created by K.Hatano on 2021/11/01.
//

import Foundation
import WatchConnectivity

protocol PhoneConnectorDelegate {
    func onReceiveMessage(_ message: [String : Any])
}

class PhoneConnector: NSObject, WCSessionDelegate {
    
    var delegate: PhoneConnectorDelegate? = nil
    
    init(delegate: PhoneConnectorDelegate) {
        self.delegate = delegate
        super.init()
        
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    var isReachable: Bool {
        return WCSession.default.isReachable
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidCompleteWith state=\(activationState.rawValue)")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("didReceiveMessage message = \(message)")
        DispatchQueue.main.async {
            self.delegate?.onReceiveMessage(message)
        }
    }
    
    func send(message: [String : Any]) {
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(message, replyHandler: nil) { error in
                print(error)
            }
        }
    }
    
}
