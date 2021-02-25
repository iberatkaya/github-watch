import SwiftyJSON

struct ProfileUser {
    init(login: String? = nil, name: String? = nil, bio: String? = nil, avatarUrl: String? = nil, email: String? = nil, followers: Int? = nil, following: Int? = nil, company: String? = nil, publicRepoCount: Int? = nil, privateRepoCount: Int? = nil, location: String? = nil, userType: String? = nil) {
        self.login = login
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
        self.userType = userType
    }

    init(dict: [String: Any]) {
        let jsonDict = JSON(dict)
        self.login = jsonDict["login"].string
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
        self.userType = jsonDict["type"].string
    }

    var login: String?
    var name: String?
    var bio: String?
    var avatarUrl: String?
    var email: String?
    var followers: Int?
    var following: Int?
    var company: String?
    var publicRepoCount: Int?
    var privateRepoCount: Int?
    var location: String?
    var userType: String?
}
