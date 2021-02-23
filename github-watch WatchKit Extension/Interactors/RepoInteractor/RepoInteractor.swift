import SwiftUI

protocol RepoInteractor {
    func requestReposOfUser(username: String, completed: @escaping ([Repo]?) -> Void) -> Void
    func requestReposByName(name: String, completed: @escaping ([Repo]?) -> Void) -> Void
}

class RealRepoInteractor: ObservableObject, RepoInteractor {
    private let repoRepository = RealRepoRepository()
    private let appState: AppState
    private var page = 1

    init(appState: AppState) {
        self.appState = appState
    }

    func resetPage() {
        page = 1
    }

    func requestReposOfUser(username: String, completed: @escaping ([Repo]?) -> Void) {
        if let accessToken = appState.user.accessToken {
            repoRepository.requestReposOfUser(username: username, accessToken: accessToken, page: page, completed: completed)
            page += 1
        }
    }

    func requestReposByName(name: String, completed: @escaping ([Repo]?) -> Void) {
        if let accessToken = appState.user.accessToken {
            repoRepository.requestReposByName(name: name, accessToken: accessToken, page: page, completed: completed)
            page += 1
        }
    }
}
