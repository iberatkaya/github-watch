import Foundation
import SwiftyJSON

protocol RepoRepository {
    func requestReposOfUser(username: String, accessToken: String, page: Int, completed: @escaping ([Repo]?) -> Void) -> Void
    
    func requestReposByName(name: String, accessToken: String, page: Int, completed: @escaping ([Repo]?) -> Void) -> Void
}

struct RealRepoRepository: RepoRepository {
    func requestReposByName(name: String, accessToken: String, page: Int, completed: @escaping ([Repo]?) -> Void) {
        let itemsPerPage = 8

        let url = URL(string: "https://api.github.com/search/repositories?q=\(name)&page=\(page)&per_page=\(itemsPerPage)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        request.setValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        do {
            let session = URLSession.shared
            session.dataTask(with: request) { data, _, error in
                if error != nil {
                    print("error \(error)")
                    return
                }
                guard let data = data else {
                    completed(nil)
                    return
                }
                let myDict = JSON(data)
                
                var repos: [Repo] = []

                for item in myDict["items"] {
                    if let dict = item.1.dictionaryObject {
                        repos.append(Repo(dict: dict))
                    }
                }

                completed(repos)
            }.resume()
        } catch {
            print(error.localizedDescription)
            completed(nil)
        }
    }
    
    func requestReposOfUser(username: String, accessToken: String, page: Int, completed: @escaping ([Repo]?) -> Void) {
        let itemsPerPage = 8

        let url = URL(string: "https://api.github.com/users/\(username)/repos?page=\(page)&per_page=\(itemsPerPage)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        request.setValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        do {
            let session = URLSession.shared
            session.dataTask(with: request) { data, _, error in
                if error != nil {
                    print("error \(error)")
                    return
                }
                guard let data = data else {
                    completed(nil)
                    return
                }
                let myDict = JSON(data)
                
                var repos: [Repo] = []

                for item in myDict {
                    if let dict = item.1.dictionaryObject {
                        repos.append(Repo(dict: dict))
                    }
                }

                completed(repos)
            }.resume()
        } catch {
            print(error.localizedDescription)
            completed(nil)
        }
    }
}
