import Foundation
import SwiftyJSON

protocol ProfileRepository {
    func requestMyProfile(accessToken: String, completed: @escaping (ProfileUser) -> Void, onError: @escaping (String) -> Void) -> Void
    func requestProfile(username: String, accessToken: String, completed: @escaping (ProfileUser) -> Void, onError: @escaping (String) -> Void) -> Void
    func requestUserOrganizations(username: String, accessToken: String, page: Int, completed: @escaping ([ProfileUser]) -> Void, onError: @escaping (String) -> Void) -> Void
    func requestSearchUsersByName(username: String, accessToken: String, page: Int, completed: @escaping ([ProfileUser]) -> Void, onError: @escaping (String) -> Void) -> Void
    func requestUserIssues(accessToken: String, page: Int, completed: @escaping ([Issue]) -> Void, onError: @escaping (String) -> Void)
    func requestMyUserOrganizations(accessToken: String, page: Int, completed: @escaping ([ProfileUser]) -> Void, onError: @escaping (String) -> Void)
}

struct RealProfileRepository: ProfileRepository {
    /// Request a the signed in user's profile using the access token.
    ///
    /// - Parameters:
    ///     - accessToken: The GitHub user's OAuth accessToken.
    ///     - completed: The closure to call when the user profile is fetched.
    ///     - onError: The closure to call when an error occurs. Returns the error string.
    func requestMyProfile(accessToken: String, completed: @escaping (ProfileUser) -> Void, onError: @escaping (String) -> Void) {
        guard let request = urlRequest(url: "https://api.github.com/user", accessToken: accessToken) else {
            onError("Incorrect Request")
            return
        }
        
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
    ///     - completed: The closure to call when the user profile is fetched.
    ///     - onError: The closure to call when an error occurs. Returns the error string.
    func requestProfile(username: String, accessToken: String, completed: @escaping (ProfileUser) -> Void, onError: @escaping (String) -> Void) {
        guard let request = urlRequest(url: "https://api.github.com/users/\(username)", accessToken: accessToken) else {
            onError("Incorrect Request")
            return
        }
        
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
    /// Request the authenticaed user's organizations.
    ///
    /// - Parameters:
    ///     - accessToken: The GitHub user's OAuth accessToken.
    ///     - page: The page of the request.
    ///     - completed: The closure to call when the user's organizations are fetched.
    ///     - onError: The closure to call when an error occurs. Returns the error string.
    func requestMyUserOrganizations(accessToken: String, page: Int, completed: @escaping ([ProfileUser]) -> Void, onError: @escaping (String) -> Void) {
        let itemsPerPage = 8
        
        guard let request = urlRequest(url: "https://api.github.com/user/orgs?page=\(page)&per_page=\(itemsPerPage)", accessToken: accessToken) else {
            onError("Incorrect Request")
            return
        }
        
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
    
    /// Request a user's organizations.
    ///
    /// - Parameters:
    ///     - username: The GitHub user's username.
    ///     - accessToken: The GitHub user's OAuth accessToken.
    ///     - page: The page of the request.
    ///     - completed: The closure to call when the user's organizations are fetched.
    ///     - onError: The closure to call when an error occurs. Returns the error string.
    func requestUserOrganizations(username: String, accessToken: String, page: Int, completed: @escaping ([ProfileUser]) -> Void, onError: @escaping (String) -> Void) {
        let itemsPerPage = 8
        
        guard let request = urlRequest(url: "https://api.github.com/users/\(username)/orgs?page=\(page)&per_page=\(itemsPerPage)", accessToken: accessToken) else {
            onError("Incorrect Request")
            return
        }
        
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
    ///     - completed: The closure to call when the user's followers or following are fetched.
    ///     - onError: The closure to call when an error occurs. Returns the error string.
    func requestUserFollowersOrFollowings(username: String, accessToken: String, userFollowType: UserFollowType, page: Int, completed: @escaping ([ProfileUser]) -> Void, onError: @escaping (String) -> Void) {
        let itemsPerPage = 8
        
        guard let request = urlRequest(url: "https://api.github.com/users/\(username)/\(userFollowType.rawValue)?page=\(page)&per_page=\(itemsPerPage)", accessToken: accessToken) else {
            onError("Incorrect Request")
            return
        }
        
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

    func requestSearchUsersByName(username: String, accessToken: String, page: Int, completed: @escaping ([ProfileUser]) -> Void, onError: @escaping (String) -> Void) {
        let itemsPerPage = 8
        
        guard let request = urlRequest(url: "https://api.github.com/search/users?q=\(username)&page=\(page)&per_page=\(itemsPerPage)", accessToken: accessToken) else {
            onError("Incorrect Request")
            return
        }

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
            
            guard let items = jsonData["items"].array else {
                onError("Users could not be found.")
                return
            }
            
            var users: [ProfileUser] = []

            for item in items {
                if let dict = item.dictionaryObject {
                    users.append(ProfileUser(dict: dict))
                }
            }
            
            completed(users)
            
        }.resume()
    }
    
    /// Request a user's assigned issues.
    ///
    /// - Parameters:
    ///     - accessToken: The GitHub user's OAuth accessToken.
    ///     - page: The page of the request.
    ///     - completed: The closure to call when the repositories are fetched.
    ///     - onError: The closure to call when an error occurs. Returns the error string.
    func requestUserIssues(accessToken: String, page: Int, completed: @escaping ([Issue]) -> Void, onError: @escaping (String) -> Void) {
        let itemsPerPage = 12

        guard let request = urlRequest(url: "https://api.github.com/issues?page=\(page)&per_page=\(itemsPerPage)&sort=created&direction=desc&state=all", accessToken: accessToken) else {
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
            
            print(myDict)

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
}

enum UserFollowType: String {
    case following
    case followers
}
