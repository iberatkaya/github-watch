import Foundation
import SwiftyJSON

protocol AuthRepository {
    func requestAccessToken(code: String, completed: @escaping (String?) -> Void) -> Void
}

struct RealAuthRepository: AuthRepository {
    func requestAccessToken(code: String, completed: @escaping (String?) -> Void) {
        let url = URL(string: "https://github.com/login/oauth/access_token?code=\(code)&client_id=\(clientID)&client_secret=\(clientSecret)&state=abcde&redirect_uri=\(redirectUrl)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        
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
            
            guard let accessToken = myDict["access_token"].string else {
                print("Access token does not exist")
                return
            }
            completed(accessToken)
        }.resume()
    }
}
