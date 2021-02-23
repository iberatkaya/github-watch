import SwiftUI

protocol MarkdownInteractor {
    func requestREADME(username: String, repo: String, completed: @escaping (String?) -> Void) -> Void
}

class RealMarkdownInteractor: ObservableObject, MarkdownInteractor {
    private let markdownRepository = RealMarkdownRepository()
    private let appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }

    func requestREADME(username: String, repo: String, completed: @escaping (String?) -> Void) {
        markdownRepository.requestREADME(username: username, repo: repo, completed: completed)
    }
}
