import SwiftUI

protocol CommentsViewModel {
    func requestCommentsOfIssue(username: String, repoName: String, issueID: String) -> Void
}

class RealCommentsViewModel: ObservableObject, CommentsViewModel {
    private let issueRepository = RealRepoRepository()
    private let appState: AppState
    private let issue: Issue

    /// The page counter for the `requestIssuesByRepoName` function. Used for pagination.
    private var requestIssuesByRepoNamePage = 1
    
    /// The fetched issues.
    @Published var comments: [Comment] = []
    
    /// Determines whether more data can be fetched. Is false if the response contains no more data.
    @Published var canFetchMore = true
    
    /// Determines whether a request is being made.
    @Published var loading = true
    
    /// Displays the error string. Is null if an error does not exist.
    @Published var error: String?

    init(appState: AppState, issue: Issue) {
        self.appState = appState
        self.issue = issue
    }
    
    /// Request a repository's issues.
    ///
    /// - Parameters:
    ///     - username: The GitHub user's username.
    ///     - repoName: The repository name.
    ///     - issueID: The issue's ID.
    func requestCommentsOfIssue(username: String, repoName: String, issueID: String) {
        if let accessToken = appState.user.accessToken {
            loading = true
            issueRepository.requestCommentsOfIssue(username: username, repoName: repoName, issueID: issueID, accessToken: accessToken, page: requestIssuesByRepoNamePage, completed: { fetchedComments in
                DispatchQueue.main.async {
                    self.comments += fetchedComments
                    if fetchedComments.isEmpty {
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
