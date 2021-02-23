import SwiftUI

protocol RepoInteractor {
    func requestReposOfUser(username: String, completed: @escaping ([Repo]?) -> Void) -> Void
}

class RealRepoInteractor: ObservableObject, RepoInteractor {
    private let repoRepository = RealRepoRepository()
    private let appState: AppState
    
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    func requestReposOfUser(username: String, completed: @escaping ([Repo]?) -> Void){
        if let accessToken = appState.user.accessToken {
            repoRepository.requestReposOfUser(username: username, accessToken: accessToken, completed: completed)
        }
    }
}
