import SwiftUI

protocol AuthViewModel {
    func signOut()
}

class RealAuthViewModel: ObservableObject, AuthViewModel {
    private let appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }

    /// Sign the user out.
    func signOut() {
        appState.user.accessToken = nil
    }
}
