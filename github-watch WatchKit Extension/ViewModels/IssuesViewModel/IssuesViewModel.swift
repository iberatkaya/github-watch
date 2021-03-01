import SwiftUI

protocol IssuesViewModel {
    func requestIssuesByRepoName(username: String, repoName: String) -> Void
}

class RealIssuesViewModel: ObservableObject, IssuesViewModel {
    private let issueRepository = RealRepoRepository()
    private let appState: AppState

    /// The page counter for the `requestIssuesByRepoName` function. Used for pagination.
    private var requestIssuesByRepoNamePage = 1
    
    /// The fetched issues.
    @Published var issues: [Issue] = []
    
    /// Determines whether more data can be fetched. Is false if the response contains no more data.
    @Published var canFetchMore = true
    
    /// Determines whether a request is being made.
    @Published var loading = true
    
    /// Displays the error string. Is null if an error does not exist.
    @Published var error: String?

    init(appState: AppState) {
        self.appState = appState
    }
    
    /// Request a repository's issues.
    ///
    /// - Parameters:
    ///     - username: The GitHub user's username.
    ///     - repoName: The repository name.
    func requestIssuesByRepoName(username: String, repoName: String) {
        if let accessToken = appState.user.accessToken {
            loading = true
            issueRepository.requestIssuesByRepoName(username: username, repoName: repoName, accessToken: accessToken, page: requestIssuesByRepoNamePage, completed: { fetchedIssues in
                DispatchQueue.main.async {
                    self.issues += fetchedIssues
                    if fetchedIssues.isEmpty {
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
            requestIssuesByRepoNamePage += 1
        }
    }
}
