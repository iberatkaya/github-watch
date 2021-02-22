import SwiftUI

protocol AuthInteractor {
    func requestAccessToken(code: String, completed: @escaping (String?) -> Void) -> Void
    func signOut()
}

class RealAuthInteractor: ObservableObject, AuthInteractor {
    private let authRepository: AuthRepository = RealAuthRepository()
    private let appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    func requestAccessToken(code: String, completed: @escaping (String?) -> Void) {
        authRepository.requestAccessToken(code: code, completed: { accessToken in
            if let accessToken = accessToken {
                DispatchQueue.main.async {
                    self.appState.user.accessToken = accessToken
                }
                completed(accessToken)
            }
            else {
                completed(nil)
            }
        })
    }
    
    func signOut() {
        appState.user.accessToken = nil
    }
}
