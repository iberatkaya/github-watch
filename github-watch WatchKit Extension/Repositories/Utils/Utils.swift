import Foundation
import SwiftyJSON

func urlRequest(url: String, accessToken: String) -> URLRequest {
    let url = URL(string: url)!

    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
    request.setValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
    return request
}
