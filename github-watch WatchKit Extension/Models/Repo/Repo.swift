import Foundation
import SwiftyJSON

struct Repo: Identifiable {
    var id = UUID()

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

    var name: String
    var ownerName: String
    var issueCount: Int
    var forks: Int
    var starCount: Int
    var watcherCount: Int
    var description: String?
    var language: String?
    var licenseName: String?
}
