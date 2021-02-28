
import Foundation
import WatchConnectivity

class ConnectivityController: NSObject, WCSessionDelegate, ObservableObject {
    var session: WCSession?
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            self.session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {}
    
    func sessionDidDeactivate(_ session: WCSession) {}
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {}
    
    
    func sendOAuthTokenToWatch(token: String) {
        session?.sendMessage(["type": "sendOAuthToken", "oAuthToken": token], replyHandler: nil, errorHandler: nil)
    }
}
