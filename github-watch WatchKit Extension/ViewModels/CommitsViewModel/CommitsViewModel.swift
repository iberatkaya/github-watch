import SwiftUI

protocol CommitsViewModel {
    func requestCommitsByRepoName(username: String, repoName: String) -> Void
}

class RealCommitsViewModel: ObservableObject, CommitsViewModel {
    private let commitRepository = RealRepoRepository()
    private let appState: AppState
    
    /// The page counter for the `requestCommitsByRepoName` function. Used for pagination.
    private var requestCommitsByRepoNamePage = 1
    
    /// The fetched commits
    @Published var commits: [Commit] = []
    
    /// Determines whether more data can be fetched. Is false if the response contains no more data.
    @Published var canFetchMore = true
    
    /// Determines whether a request is being made.
    @Published var loading = true
    
    /// Displays the error string. Is null if an error does not exist.
    @Published var error: String?
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    func requestCommitsByRepoName(username: String, repoName: String) {
        if let accessToken = appState.user.accessToken {
            loading = true
            commitRepository.requestReposCommits(username: username, repoName: repoName, accessToken: accessToken, page: requestCommitsByRepoNamePage, completed: {
                fetchedCommits in
                DispatchQueue.main.async {
                    self.commits += fetchedCommits
                    if fetchedCommits.isEmpty {
                        self.canFetchMore = false
                    }
                    self.error = nil
                    self.loading = false
                }
            }, onError: { err in
                DispatchQueue.main.async {
                    self.loading = false
                    self.error = err
                }
            })
            requestCommitsByRepoNamePage += 1
        }
    }
}
