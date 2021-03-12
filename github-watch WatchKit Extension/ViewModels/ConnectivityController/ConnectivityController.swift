import SwiftUI
import WatchConnectivity

class ConnectivityController: NSObject, WCSessionDelegate, ObservableObject {
    var session: WCSession?
    var appState: AppState
    var profileRepository = RealProfileRepository()
    
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
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        guard let type = message["type"] as? String else {
            return
        }
        if type == "sendOAuthToken" {
            guard let token = message["oAuthToken"] as? String
            else {
                return
            }
            if appState.user.accessToken != token {
                DispatchQueue.main.async {
                    self.appState.user.accessToken = token
                }
                profileRepository.requestMyProfile(accessToken: token, completed: { profileUser in
                    DispatchQueue.main.async {
                        if let name = profileUser.username {
                            self.appState.user.username = name
                        }
                    }
                }, onError: { _ in })
            }
        }
    }
}
