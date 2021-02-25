import SwiftUI

protocol AuthInteractor {
    func signOut()
}

class RealAuthInteractor: ObservableObject, AuthInteractor {
    private let appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }
    
    ///Sign the user out.
    func signOut() {
        appState.user.accessToken = nil
    }
}
