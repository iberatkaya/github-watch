import SwiftUI

protocol CommitsViewModel {
    func requestCommitsByRepoName(username: String, repoName: String) -> Void
}

class RealCommitsViewModel: ObservableObject, CommitsViewModel {
    private let commitRepository = RealRepoRepository()
    private let appState: AppState
}
