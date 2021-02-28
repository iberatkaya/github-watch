import Foundation
import SwiftyJSON

protocol ProfileRepository {
    func requestMyProfile(accessToken: String, completed: @escaping (ProfileUser) -> Void, onError: @escaping (String) -> Void) -> Void
    func requestProfile(username: String, accessToken: String, completed: @escaping (ProfileUser) -> Void, onError: @escaping (String) -> Void) -> Void
    func requestUserOrganizations(username: String, accessToken: String, page: Int, completed: @escaping ([ProfileUser]) -> Void, onError: @escaping (String) -> Void) -> Void
}

struct RealProfileRepository: ProfileRepository {
    
    /// Request a the signed in user's profile using the access token.
    ///
    /// - Parameters:
    ///     - accessToken: The GitHub user's OAuth accessToken.
    ///     - completed: The clouse to call when the user profile is fetched.
    ///     - onError: The clouse to call when an error occurs. Returns the error string.
    func requestMyProfile(accessToken: String, completed: @escaping (ProfileUser) -> Void, onError: @escaping (String) -> Void) {
        let request = urlRequest(url: "https://api.github.com/user", accessToken: accessToken)

        let session = URLSession.shared
        session.dataTask(with: request) { data, _, error in
            if let error = error {
                onError(error.localizedDescription)
                return
            }
            
            let jsonData = JSON(data)
            
            if let errorMessage = jsonData["message"].string {
                onError(errorMessage)
                return
            }
            
            guard let dict = jsonData.dictionaryObject else {
                onError("JSON Data is null")
                return
            }
            
            let profileUser = ProfileUser(dict: dict)
            completed(profileUser)
        }.resume()
    }
    
    /// Request a user's profile.
    ///
    /// - Parameters:
    ///     - username: The GitHub user's username.
    ///     - accessToken: The GitHub user's OAuth accessToken.
    ///     - completed: The clouse to call when the user profile is fetched.
    ///     - onError: The clouse to call when an error occurs. Returns the error string.
    func requestProfile(username: String, accessToken: String, completed: @escaping (ProfileUser) -> Void, onError: @escaping (String) -> Void) {
        let request = urlRequest(url: "https://api.github.com/users/\(username)", accessToken: accessToken)
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, _, error in
            if let error = error {
                onError(error.localizedDescription)
                return
            }
            
            let jsonData = JSON(data)
            
            if let errorMessage = jsonData["message"].string {
                onError(errorMessage)
                return
            }
            
            guard let dict = jsonData.dictionaryObject else {
                onError("JSON Data is null")
                return
            }
            
            let profileUser = ProfileUser(dict: dict)
            completed(profileUser)
        }.resume()
    }
    
    /// Request a user's organizations.
    ///
    /// - Parameters:
    ///     - username: The GitHub user's username.
    ///     - accessToken: The GitHub user's OAuth accessToken.
    ///     - page: The page of the request.
    ///     - completed: The clouse to call when the user's organizations are fetched.
    ///     - onError: The clouse to call when an error occurs. Returns the error string.
    func requestUserOrganizations(username: String, accessToken: String, page: Int, completed: @escaping ([ProfileUser]) -> Void, onError: @escaping (String) -> Void) {
        let itemsPerPage = 8
        
        let request = urlRequest(url: "https://api.github.com/users/\(username)/orgs?page=\(page)&per_page=\(itemsPerPage)", accessToken: accessToken)
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, _, error in
            if let error = error {
                onError(error.localizedDescription)
                return
            }
            
            let jsonData = JSON(data)
            
            if let errorMessage = jsonData["message"].string {
                onError(errorMessage)
                return
            }
            
            var organizations: [ProfileUser] = []

            for item in jsonData {
                if let dict = item.1.dictionaryObject {
                    organizations.append(ProfileUser(dict: dict))
                }
            }
            
            completed(organizations)
            
        }.resume()
    }
    
    /// Request a user's followers or following.
    ///
    /// - Parameters:
    ///     - username: The GitHub user's username.
    ///     - accessToken: The GitHub user's OAuth accessToken.
    ///     - userFollowType: Determines to get the user's followings or followers.
    ///     - page: The page of the request.
    ///     - completed: The clouse to call when the user's followers or following are fetched.
    ///     - onError: The clouse to call when an error occurs. Returns the error string.
    func requestUserFollowersOrFollowings(username: String, accessToken: String, userFollowType: UserFollowType, page: Int, completed: @escaping ([ProfileUser]) -> Void, onError: @escaping (String) -> Void) {
        let itemsPerPage = 8
        
        let request = urlRequest(url: "https://api.github.com/users/\(username)/\(userFollowType.rawValue)?page=\(page)&per_page=\(itemsPerPage)", accessToken: accessToken)
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, _, error in
            if let error = error {
                onError(error.localizedDescription)
                return
            }
            
            let jsonData = JSON(data)
            
            if let errorMessage = jsonData["message"].string {
                onError(errorMessage)
                return
            }
            
            var organizations: [ProfileUser] = []

            for item in jsonData {
                if let dict = item.1.dictionaryObject {
                    organizations.append(ProfileUser(dict: dict))
                }
            }
            
            completed(organizations)
            
        }.resume()
    }
}

enum UserFollowType: String {
    case following
    case followers
}
