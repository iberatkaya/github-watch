import Foundation
import SwiftyJSON

struct Repo: Identifiable {
    internal init(name: String, ownerName: String, issueCount: Int, forks: Int, starCount: Int, watcherCount: Int, description: String? = nil, language: String? = nil, licenseName: String? = nil) {
        self.name = name
        self.ownerName = ownerName
        self.issueCount = issueCount
        self.forks = forks
        self.starCount = starCount
        self.watcherCount = watcherCount
        self.description = description
        self.language = language
        self.licenseName = licenseName
    }

    init(dict: [String: Any]) {
        let jsonDict = JSON(dict)
        self.name = jsonDict["name"].string ?? ""
        self.ownerName = jsonDict["owner"]["login"].string ?? ""
        self.issueCount = jsonDict["open_issues"].int ?? 0
        self.forks = jsonDict["forks"].int ?? 0
        self.starCount = jsonDict["stargazers_count"].int ?? 0
        self.watcherCount = jsonDict["watchers"].int ?? 0
        self.description = jsonDict["description"].string
        self.language = jsonDict["language"].string
        self.licenseName = jsonDict["license"]["name"].string
    }

    /// The repository's created unique id. This is used for displaying the repository in a list.
    var id = UUID()

    /// The name of the repository.
    var name: String
    
    /// The repository owner's name.
    var ownerName: String
    
    /// The number of issues of the repository.
    var issueCount: Int
    
    /// The number of forks of the repository.
    var forks: Int
    
    /// The number of star of the repository.
    var starCount: Int
    
    /// The number of watchers of the repository.
    var watcherCount: Int
    
    /// The description of the repository.
    var description: String?
    
    /// The langauge of the repository.
    var language: String?
    
    /// The name of the license of the repository.
    var licenseName: String?
}
