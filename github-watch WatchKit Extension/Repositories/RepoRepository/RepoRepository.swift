import Foundation
import SwiftyJSON

protocol RepoRepository {
    func requestReposOfUser(username: String, accessToken: String, completed: @escaping (String?) -> Void) -> Void
}

struct RealRepoRepository: RepoRepository {
    func requestReposOfUser(username: String, accessToken: String, completed: @escaping (String?) -> Void) {
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
                
                guard let accessToken = myDict["access_token"].string else {
                    print("Access token does not exist")
                    return
                }
                completed(accessToken)
            }.resume()
        } catch {
            print(error.localizedDescription)
            completed(nil)
        }
    }
}
