import Foundation
import SwiftyJSON

protocol RepoRepository {
    func requestReposOfUser(username: String, accessToken: String, completed: @escaping ([Repo]?) -> Void) -> Void
}

struct RealRepoRepository: RepoRepository {
    func requestReposOfUser(username: String, accessToken: String, completed: @escaping ([Repo]?) -> Void) {
        let url = URL(string: "https://api.github.com/users/\(username)/repos")!
        print("request \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        do {
            let session = URLSession.shared
            session.dataTask(with: request)  { (data, response, error)  in
                if error != nil {
                    print("error \(error)")
                    return
                }
                guard let data = data else {
                    completed(nil)
                    return
                }
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                }
                let myDict = JSON(data)
                print(myDict)
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
