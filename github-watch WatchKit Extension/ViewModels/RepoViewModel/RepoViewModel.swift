import SwiftUI

protocol RepoViewModel {
    func requestReposOfUser(username: String) -> Void
    func requestReposByName(name: String) -> Void
}

class RealRepoViewModel: ObservableObject, RepoViewModel {
    private let repoRepository = RealRepoRepository()
    private let appState: AppState

    /// The page counter for the `requestReposOfUser` function. Used for pagination.
    private var requestReposOfUserPage = 1

    /// The page counter for the `requestReposByName` function. Used for pagination.
    private var requestReposByNamePage = 1

    /// Determines whether a request is being made.
    @Published var loading = false

    /// The fetched repositories.
    @Published var repos: [Repo] = []

    /// Determines whether more data can be fetched. Is false if the response contains no more data.
    @Published var canFetchMore = true

    /// Displays the error string. Is null if an error does not exist.
    @Published var error: String?

    init(appState: AppState) {
        self.appState = appState
    }

    /// Request a user's repositories using the user's username.
    ///
    /// - Parameters:
    ///     - username: The GitHub username of the user.
    func requestReposOfUser(username: String) {
        if let accessToken = appState.user.accessToken {
            loading = true
            repoRepository.requestReposOfUser(username: username, accessToken: accessToken, page: requestReposOfUserPage, completed: { myRepos in
                DispatchQueue.main.async {
                    self.repos += myRepos
                    if myRepos.isEmpty {
                        self.canFetchMore = false
                    }
                    self.loading = false
                    self.error = nil
                }

            }, onError: { err in
                DispatchQueue.main.async {
                    self.loading = false
                    self.error = err
                }
            })
            requestReposOfUserPage += 1
        }
    }

    /// Search for repositories.
    ///
    /// - Parameters:
    ///     - name: The searched term.
    func requestReposByName(name: String) {
        if let accessToken = appState.user.accessToken {
            loading = true
            repoRepository.requestReposByName(name: name, accessToken: accessToken, page: requestReposByNamePage, completed: { myRepos in
                DispatchQueue.main.async {
                    self.repos += myRepos
                    if myRepos.isEmpty {
                        self.canFetchMore = false
                    }
                    self.loading = false
                    self.error = nil
                }

            }, onError: { err in
                DispatchQueue.main.async {
                    self.loading = false
                    self.error = err
                }
            })
            requestReposByNamePage += 1
        }
    }
}
