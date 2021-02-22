import SwiftUI

protocol ProfileInteractor {
    func requestProfile(username: String, completed: @escaping () -> Void) -> Void
}

class RealProfileInteractor: ObservableObject, ProfileInteractor {
    private let appState: AppState
    private let profileAuthRepository = RealProfileRepository()
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    
    func requestProfile(username: String, completed: @escaping () -> Void) {
        if let accessToken = appState.user.accessToken {
            profileAuthRepository.requestProfile(username: username, accessToken: accessToken, completed: completed)
        }
    }
    
    func signOut() {
        appState.user.accessToken = nil
    }
}
