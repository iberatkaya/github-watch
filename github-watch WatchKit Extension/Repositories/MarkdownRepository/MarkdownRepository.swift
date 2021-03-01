import Foundation
import SwiftyJSON

protocol MarkdownRepository {
    func requestREADME(username: String, repo: String, completed: @escaping (String) -> Void, onError: @escaping (String) -> Void)
}

struct RealMarkdownRepository: MarkdownRepository {
    /// Request a repository's README file.
    ///
    /// - Parameters:
    ///     - username: The GitHub username of the user.
    ///     - repo: The name of the repository.
    ///     - accessToken: The GitHub user's OAuth accessToken.
    ///     - completed: The clouse to call when the README is fetched. Returns nil if an error occurs.
    ///     - onError: The clouse to call when an error occurs. Returns the error string.
    func requestREADME(username: String, repo: String, completed: @escaping (String) -> Void, onError: @escaping (String) -> Void) {
        // Try to fetch the README from the main branch.
        let mainUrl = URL(string: "https://raw.githubusercontent.com/\(username)/\(repo)/main/README.md")

        FileDownloader.loadFileAsync(url: mainUrl!, completion: { path, error in
            if error != nil {
                // If the README is not found from the main branch,
                // try to fetch the README from the main branch.
                let masterUrl = URL(string: "https://raw.githubusercontent.com/\(username)/\(repo)/master/README.md")
                FileDownloader.loadFileAsync(url: masterUrl!, completion: { path, error in
                    if let error = error {
                        onError(error.localizedDescription)
                        return
                    }
                    do {
                        let text = try String(contentsOf: URL(string: "file://\(path!)")!, encoding: .utf8)
                        completed(text)
                    } catch {
                        onError(error.localizedDescription)
                    }
                })
                return
            }
            do {
                let text = try String(contentsOf: URL(string: "file://\(path!)")!, encoding: .utf8)
                completed(text)
            } catch {
                onError(error.localizedDescription)
            }
        })
    }
}
