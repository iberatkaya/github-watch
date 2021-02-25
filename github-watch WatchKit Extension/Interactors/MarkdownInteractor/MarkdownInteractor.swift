import SwiftUI

protocol MarkdownInteractor {
    func requestREADME(username: String, repo: String, completed: @escaping (String) -> Void, onError: @escaping (String) -> Void) -> Void
}

class RealMarkdownInteractor: ObservableObject, MarkdownInteractor {
    private let markdownRepository = RealMarkdownRepository()
    private let appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }

    ///Request a repository's README file.
    ///
    ///- Parameters:
    ///     - username: The GitHub username of the user.
    ///     - repo: The name of the repository.
    ///     - completed: The clouse to call when the README is fetched. Returns nil if an error occurs.
    ///     - onError: The clouse to call when an error occurs. Returns the error string.
    func requestREADME(username: String, repo: String, completed: @escaping (String) -> Void, onError: @escaping (String) -> Void = {_ in}) {
        markdownRepository.requestREADME(username: username, repo: repo, completed: completed, onError: onError)
    }
}
