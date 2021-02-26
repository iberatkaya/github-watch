import SwiftUI

protocol MarkdownViewModel {
    func requestREADME(username: String, repo: String) -> Void
}

class RealMarkdownViewModel: ObservableObject, MarkdownViewModel {
    private let markdownRepository = RealMarkdownRepository()
    private let appState: AppState
    
    ///Determines whether a file is being downloaded.
    @Published var downloading = true
    
    ///Displays the markdown text. Is null initially.
    @Published var markdown: String?

    init(appState: AppState) {
        self.appState = appState
    }

    /// Request a repository's README file.
    ///
    /// - Parameters:
    ///     - username: The GitHub username of the user.
    ///     - repo: The name of the repository.
    func requestREADME(username: String, repo: String) {
        markdownRepository.requestREADME(username: username, repo: repo, completed: { markdownText in
            DispatchQueue.main.async {
                self.downloading = false
                self.markdown = markdownText
            }
        }, onError: { _ in })
    }
}
