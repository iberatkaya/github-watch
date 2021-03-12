
import Foundation
import WatchConnectivity

class ConnectivityController: NSObject, WCSessionDelegate, ObservableObject {
    var session: WCSession?
    var appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
        super.init()
        if WCSession.isSupported() {
            self.session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    
    func sessionDidBecomeInactive(_ session: WCSession) {}
    
    func sessionDidDeactivate(_ session: WCSession) {}
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {}
    
    func sendOAuthTokenToWatch(token: String, onError: @escaping (String) -> Void = { _ in }) {
        session?.sendMessage(["type": "sendOAuthToken", "oAuthToken": token], replyHandler: nil, errorHandler: { error in
            onError(error.localizedDescription + "\nPlease resend the OAuth Token!")
        })
    }
}
