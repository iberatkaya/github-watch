import Foundation
import SwiftyJSON

protocol MarkdownRepository {
    func requestREADME(username: String, repo: String, completed: @escaping (String?) -> Void)
}

struct RealMarkdownRepository: MarkdownRepository {
    func requestREADME(username: String, repo: String, completed: @escaping (String?) -> Void) {
        // Try to fetch the README from the main branch.
        let mainUrl = URL(string: "https://raw.githubusercontent.com/\(username)/\(repo)/main/README.md")

        FileDownloader.loadFileAsync(url: mainUrl!, completion: { path, error in
            if let error = error {
                // If the README is not found from the main branch,
                // try to fetch the README from the main branch.
                let masterUrl = URL(string: "https://raw.githubusercontent.com/\(username)/\(repo)/master/README.md")
                FileDownloader.loadFileAsync(url: masterUrl!, completion: { path, error in
                    if let error = error {
                        completed(nil)
                        return
                    }
                    do {
                        let text = try String(contentsOf: URL(string: "file://\(path!)")!, encoding: .utf8)
                        completed(text)
                    } catch {
                        print(error.localizedDescription)
                    }

                })
                return
            }
            do {
                let text = try String(contentsOf: URL(string: "file://\(path!)")!, encoding: .utf8)
                completed(text)
            } catch {
                print(error.localizedDescription)
            }
        })
    }
}
