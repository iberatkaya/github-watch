import SwiftUI

protocol AuthInteractor {
    func signOut()
}

class RealAuthInteractor: ObservableObject, AuthInteractor {
    private let appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    func signOut() {
        appState.user.accessToken = nil
    }
}
