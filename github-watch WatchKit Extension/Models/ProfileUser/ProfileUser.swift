import Foundation
import SwiftyJSON

struct ProfileUser: Identifiable {
    init(username: String? = nil, name: String? = nil, bio: String? = nil, avatarUrl: String? = nil, email: String? = nil, followers: Int? = nil, following: Int? = nil, company: String? = nil, publicRepoCount: Int? = nil, privateRepoCount: Int? = nil, location: String? = nil, userType: UserType? = nil) {
        self.username = username
        self.name = name
        self.bio = bio
        self.avatarUrl = avatarUrl
        self.email = email
        self.followers = followers
        self.following = following
        self.company = company
        self.publicRepoCount = publicRepoCount
        self.privateRepoCount = privateRepoCount
        self.location = location
        self.userType = userType ?? UserType.other
    }

    init(dict: [String: Any]) {
        let jsonDict = JSON(dict)
        self.username = jsonDict["login"].string
        self.name = jsonDict["name"].string
        self.bio = jsonDict["bio"].string
        self.avatarUrl = jsonDict["avatar_url"].string
        self.email = jsonDict["email"].string
        self.followers = jsonDict["followers"].int
        self.following = jsonDict["following"].int
        self.company = jsonDict["company"].string
        self.publicRepoCount = jsonDict["public_repos"].int
        self.privateRepoCount = jsonDict["total_private_repos"].int
        self.location = jsonDict["location"].string
        self.userType = UserType(rawValue: jsonDict["type"].string ?? "") ?? UserType.other
    }
    
    /// The user's created unique id. This is used for displaying the user in a list.
    var id = UUID()
    
    /// The username of the user. Example: @johndoe
    var username: String?
    
    /// The display name of the user. Example: John Doe
    var name: String?
    
    /// The biography of the user.
    var bio: String?
    
    /// The user's avatar url.
    var avatarUrl: String?
    
    /// The user's email.
    var email: String?
    
    /// The user's follow count.
    var followers: Int?
    
    /// The user's following count.
    var following: Int?
    
    /// The user's company.
    var company: String?
    
    /// The user's public repository count.
    var publicRepoCount: Int?
    
    /// The user's private repository count. This is only displayed when the user has access to this information.
    /// Example: When a user views its own profile.
    var privateRepoCount: Int?
    
    /// The user's location.
    var location: String?
    
    /// The user's user type.
    var userType: UserType
}
