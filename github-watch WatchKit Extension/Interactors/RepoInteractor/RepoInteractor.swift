import SwiftUI

protocol RepoInteractor {
    func requestReposOfUser(username: String, completed: @escaping ([Repo]) -> Void, onError: @escaping (String) -> Void) -> Void
    func requestReposByName(name: String, completed: @escaping ([Repo]) -> Void, onError: @escaping (String) -> Void) -> Void
}

class RealRepoInteractor: ObservableObject, RepoInteractor {
    private let repoRepository = RealRepoRepository()
    private let appState: AppState
    private var requestReposOfUserPage = 1
    private var requestReposByNamePage = 1

    init(appState: AppState) {
        self.appState = appState
    }

    func resetRequestReposOfUserPage() {
        requestReposOfUserPage = 1
    }
    
    func resetRequestReposByNamePage() {
        requestReposByNamePage = 1
    }

    ///Request a user's repositories using the user's username.
    ///
    ///- Parameters:
    ///     - username: The GitHub username of the user.
    ///     - page: The page of the request.
    ///     - completed: The clouse to call when the repositories are fetched. Returns nil if an error occurs.
    ///     - onError: The clouse to call when an error occurs. Returns the error string.
    func requestReposOfUser(username: String, completed: @escaping ([Repo]) -> Void, onError: @escaping (String) -> Void = {_ in }) {
        if let accessToken = appState.user.accessToken {
            repoRepository.requestReposOfUser(username: username, accessToken: accessToken, page: requestReposOfUserPage, completed: completed, onError: onError)
            requestReposOfUserPage += 1
        }
    }

    ///Search for repositories.
    ///
    ///- Parameters:
    ///     - name: The searched term.
    ///     - page: The page of the request.
    ///     - completed: The clouse to call when the repositories are fetched. Returns nil if an error occurs.
    ///     - onError: The clouse to call when an error occurs. Returns the error string.
    func requestReposByName(name: String, completed: @escaping ([Repo]) -> Void, onError: @escaping (String) -> Void = {_ in }) {
        if let accessToken = appState.user.accessToken {
            repoRepository.requestReposByName(name: name, accessToken: accessToken, page: requestReposByNamePage, completed: completed, onError: onError)
            requestReposByNamePage += 1
        }
    }
}
