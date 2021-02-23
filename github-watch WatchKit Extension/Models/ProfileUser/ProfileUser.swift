import SwiftyJSON
struct ProfileUser {
    init(login: String? = nil, name: String? = nil, bio: String? = nil, avatarUrl: String? = nil, email: String? = nil, followers: Int? = nil, following: Int? = nil, company: String? = nil, repoCount: Int? = nil, location: String? = nil) {
        self.login = login
        self.name = name
        self.bio = bio
        self.avatarUrl = avatarUrl
        self.email = email
        self.followers = followers
        self.following = following
        self.company = company
        self.repoCount = repoCount
        self.location = location
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
        self.repoCount = jsonDict["public_repos"].int
        self.location = jsonDict["location"].string
    }
    
    var login: String?
    var name: String?
    var bio: String?
    var avatarUrl: String?
    var email: String?
    var followers: Int?
    var following: Int?
    var company: String?
    var repoCount: Int?
    var location: String?
}


/**
 * Example user:
 *{
     "followers_url" : "https:\/\/api.github.com\/users\/arasgungore\/followers",
     "node_id" : "MDQ6VXNlcjU5OTM5MzA0",
     "starred_url" : "https:\/\/api.github.com\/users\/arasgungore\/starred{\/owner}{\/repo}",
     "bio" : "Boğaziçi University Electrical and Engineering Student - fluent in C\/C++",
     "twitter_username" : null,
     "public_repos" : 1,
     "id" : 59939304,
     "followers" : 1,
     "organizations_url" : "https:\/\/api.github.com\/users\/arasgungore\/orgs",
     "updated_at" : "2021-02-01T13:29:49Z",
     "public_gists" : 0,
     "gists_url" : "https:\/\/api.github.com\/users\/arasgungore\/gists{\/gist_id}",
     "hireable" : null,
     "subscriptions_url" : "https:\/\/api.github.com\/users\/arasgungore\/subscriptions",
     "received_events_url" : "https:\/\/api.github.com\/users\/arasgungore\/received_events",
     "company" : "None",
     "name" : "Aras Güngöre",
     "url" : "https:\/\/api.github.com\/users\/arasgungore",
     "type" : "User",
     "following_url" : "https:\/\/api.github.com\/users\/arasgungore\/following{\/other_user}",
     "html_url" : "https:\/\/github.com\/arasgungore",
     "events_url" : "https:\/\/api.github.com\/users\/arasgungore\/events{\/privacy}",
     "login" : "arasgungore",
     "repos_url" : "https:\/\/api.github.com\/users\/arasgungore\/repos",
     "avatar_url" : "https:\/\/avatars.githubusercontent.com\/u\/59939304?v=4",
     "following" : 1,
     "site_admin" : false,
     "location" : "İstanbul - Kocaeli",
     "gravatar_id" : "",
     "blog" : "",
     "created_at" : "2020-01-15T22:05:47Z",
     "email" : null
 * }
 */

