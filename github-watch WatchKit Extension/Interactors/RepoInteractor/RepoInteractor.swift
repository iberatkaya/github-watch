import SwiftUI

protocol RepoInteractor {
    func requestReposOfUser(username: String, completed: @escaping (String?) -> Void) -> Void
}

class RealRepoInteractor: ObservableObject, RepoInteractor {
    private let repoRepository = RealRepoRepository()
    private let appState: AppState
    
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    func requestReposOfUser(username: String, completed: @escaping (String?) -> Void){
        print(appState.user.accessToken)
        if let accessToken = appState.user.accessToken {
            repoRepository.requestReposOfUser(username: username, accessToken: accessToken, completed: completed)
        }
    }
}
