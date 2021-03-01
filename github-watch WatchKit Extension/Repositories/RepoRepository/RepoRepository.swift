import Foundation
import SwiftyJSON

protocol RepoRepository {
    func requestReposOfUser(username: String, accessToken: String, page: Int, completed: @escaping ([Repo]) -> Void, onError: @escaping (String) -> Void) -> Void

    func requestReposByName(name: String, accessToken: String, page: Int, completed: @escaping ([Repo]) -> Void, onError: @escaping (String) -> Void) -> Void

    func requestIssuesByRepoName(username: String, repoName: String, accessToken: String, page: Int, completed: @escaping ([Issue]) -> Void, onError: @escaping (String) -> Void) -> Void
    
    func requestCommentsOfIssue(username: String, repoName: String, issueID: String, accessToken: String, page: Int, completed: @escaping ([Comment]) -> Void, onError: @escaping (String) -> Void) -> Void
}

struct RealRepoRepository: RepoRepository {
    /// Search for repositories.
    ///
    /// - Parameters:
    ///     - name: The searched term.
    ///     - accessToken: The GitHub user's OAuth accessToken.
    ///     - page: The page of the request.
    ///     - completed: The closure to call when the repositories are fetched.
    ///     - onError: The closure to call when an error occurs. Returns the error string.
    func requestReposByName(name: String, accessToken: String, page: Int, completed: @escaping ([Repo]) -> Void, onError: @escaping (String) -> Void) {
        let itemsPerPage = 8

        guard let request = urlRequest(url: "https://api.github.com/search/repositories?q=\(name)&page=\(page)&per_page=\(itemsPerPage)&sort=pushed", accessToken: accessToken) else {
            onError("Incorrect Request")
            return
        }

        let session = URLSession.shared
        session.dataTask(with: request) { data, _, error in
            if let error = error {
                onError(error.localizedDescription)
                return
            }
            guard let data = data else {
                onError("Data could not be found")
                return
            }

            let myDict = JSON(data)

            if let errorMessage = myDict["message"].string {
                onError(errorMessage)
                return
            }

            var repos: [Repo] = []

            for item in myDict["items"] {
                if let dict = item.1.dictionaryObject {
                    repos.append(Repo(dict: dict))
                }
            }

            completed(repos)
        }.resume()
    }

    /// Request a user's repositories using the user's username.
    ///
    /// - Parameters:
    ///     - username: The GitHub username of the user.
    ///     - accessToken: The GitHub user's OAuth accessToken.
    ///     - page: The page of the request.
    ///     - completed: The closure to call when the repositories are fetched.
    ///     - onError: The closure to call when an error occurs. Returns the error string.
    func requestReposOfUser(username: String, accessToken: String, page: Int, completed: @escaping ([Repo]) -> Void, onError: @escaping (String) -> Void) {
        let itemsPerPage = 8

        guard let request = urlRequest(url: "https://api.github.com/users/\(username)/repos?page=\(page)&per_page=\(itemsPerPage)&sort=pushed", accessToken: accessToken) else {
            onError("Incorrect Request")
            return
        }

        let session = URLSession.shared
        session.dataTask(with: request) { data, _, error in
            if let error = error {
                onError(error.localizedDescription)
                return
            }

            let myDict = JSON(data)

            if let errorMessage = myDict["message"].string {
                onError(errorMessage)
                return
            }

            var repos: [Repo] = []

            for item in myDict {
                if let dict = item.1.dictionaryObject {
                    repos.append(Repo(dict: dict))
                }
            }

            completed(repos)
        }.resume()
    }

    /// Request a repository's issues.
    ///
    /// - Parameters:
    ///     - username: The GitHub username of the user.
    ///     - repoName: The name of the repository.
    ///     - accessToken: The GitHub user's OAuth accessToken.
    ///     - page: The page of the request.
    ///     - completed: The closure to call when the repositories are fetched.
    ///     - onError: The closure to call when an error occurs. Returns the error string.
    func requestIssuesByRepoName(username: String, repoName: String, accessToken: String, page: Int, completed: @escaping ([Issue]) -> Void, onError: @escaping (String) -> Void) {
        let itemsPerPage = 12

        guard let request = urlRequest(url: "https://api.github.com/repos/\(username)/\(repoName)/issues?page=\(page)&per_page=\(itemsPerPage)&sort=created&direction=desc&state=all", accessToken: accessToken) else {
            onError("Incorrect Request")
            return
        }

        let session = URLSession.shared
        session.dataTask(with: request) { data, _, error in
            if let error = error {
                onError(error.localizedDescription)
                return
            }

            let myDict = JSON(data)

            if let errorMessage = myDict["message"].string {
                onError(errorMessage)
                return
            }

            var issues: [Issue] = []

            for item in myDict {
                if let dict = item.1.dictionaryObject {
                    issues.append(Issue(dict: dict))
                }
            }

            completed(issues)
        }.resume()
    }
    
    /// Request a repository issue's comments.
    ///
    /// - Parameters:
    ///     - username: The GitHub username of the user.
    ///     - repoName: The name of the repository.
    ///     - issueID: The name of the repository.
    ///     - accessToken: The GitHub user's OAuth accessToken.
    ///     - page: The page of the request.
    ///     - completed: The closure to call when the repositories are fetched.
    ///     - onError: The closure to call when an error occurs. Returns the error string.
    func requestCommentsOfIssue(username: String, repoName: String, issueID: String, accessToken: String, page: Int, completed: @escaping ([Comment]) -> Void, onError: @escaping (String) -> Void) {
        let itemsPerPage = 12
        guard let request = urlRequest(url: "https://api.github.com/repos/\(username)/\(repoName)/issues/\(issueID)/comments?page=\(page)&per_page=\(itemsPerPage)&sort=created&direction=desc&state=all", accessToken: accessToken) else {
            onError("Incorrect Request")
            return
        }

        let session = URLSession.shared
        session.dataTask(with: request) { data, _, error in
            if let error = error {
                onError(error.localizedDescription)
                return
            }

            let myDict = JSON(data)

            if let errorMessage = myDict["message"].string {
                onError(errorMessage)
                return
            }

            var comments: [Comment] = []

            for item in myDict {
                if let dict = item.1.dictionaryObject {
                    comments.append(Comment(dict: dict))
                }
            }

            completed(comments)
        }.resume()
    }
}
