import Foundation
import SwiftyJSON

protocol ProfileRepository {
    func requestMyProfile(accessToken: String, completed: @escaping (ProfileUser?) -> Void) -> Void
    func requestProfile(username: String, accessToken: String, completed: @escaping (ProfileUser?) -> Void) -> Void
}

struct RealProfileRepository: ProfileRepository {
    func requestMyProfile(accessToken: String, completed: @escaping (ProfileUser?) -> Void) {
        let url = URL(string: "https://api.github.com/user")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        request.setValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        session.dataTask(with: request) { data, _, error in
            if error != nil {
                print("error \(error)")
                return
            }
            let jsonData = JSON(data)
            if jsonData["message"].string == "Not Found" {
                completed(nil)
                return
            }
            
            guard let dict = jsonData.dictionaryObject else {
                completed(nil)
                return
            }
            
            let profileUser = ProfileUser(dict: dict)
            completed(profileUser)
        }.resume()
    }
    
    func requestProfile(username: String, accessToken: String, completed: @escaping (ProfileUser?) -> Void) {
        let url = URL(string: "https://api.github.com/users/\(username)")!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        request.setValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, _, error in
            if error != nil {
                print("error \(error)")
                return
            }
            let jsonData = JSON(data)
            
            if jsonData["message"].string == "Not Found" {
                completed(nil)
                return
            }
            
            guard let dict = jsonData.dictionaryObject else {
                completed(nil)
                return
            }
            
            let profileUser = ProfileUser(dict: dict)
            completed(profileUser)
        }.resume()
    }
}
