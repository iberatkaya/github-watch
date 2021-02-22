import Foundation
import SwiftyJSON

protocol ProfileRepository {
    func requestProfile(username: String, accessToken: String, completed: @escaping () -> Void) -> Void
}

struct RealProfileRepository: ProfileRepository {
    func requestProfile(username: String, accessToken: String, completed: @escaping () -> Void) {
        let url = URL(string: "https://api.github.com/users/\(username)")!
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        request.setValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        do {
            let session = URLSession.shared
            session.dataTask(with: request)  { (data, response, error)  in
                if error != nil {
                    print("error \(error)")
                    return
                }
                guard let data = data else {
                    completed()
                    return
                }
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                }
                do {
                    guard let myStr = String(data: data, encoding: .utf8) else {
                        print("data string error")
                        return
                    }
                    print(JSON(data))
                    completed()
                }
            }.resume()
        } catch {
            print(error.localizedDescription)
            completed()
        }
    }
}
