import Foundation
import SwiftyJSON

func urlRequest(url: String , accessToken: String) -> URLRequest? {
    guard let urlStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
          let url = URL(string: urlStr)
    else {
        return nil
    }

    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
    request.setValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
    return request
}
