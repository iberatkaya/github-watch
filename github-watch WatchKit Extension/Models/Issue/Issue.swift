import Foundation
import SwiftyJSON

struct Issue: Identifiable {
    init(title: String? = nil, body: String? = nil, owner: ProfileUser? = nil, creationDate: Date? = nil, closedDate: Date? = nil, commentsCount: Int? = nil, issueNumber: Int? = nil) {
        self.title = title
        self.body = body
        self.owner = owner
        self.creationDate = creationDate
        self.closedDate = closedDate
        self.commentsCount = commentsCount
        self.issueNumber = issueNumber
    }
    
    init(dict: [String: Any]) {
        let jsonDict = JSON(dict)
        self.title = jsonDict["title"].string ?? ""
        self.body = jsonDict["body"].string ?? ""
        if let user = jsonDict["user"].dictionaryObject {
            self.owner = ProfileUser(dict: user)
        }
        else {
            self.owner = nil
        }
        self.creationDate = jsonDict["created_at"].date
        self.closedDate = jsonDict["closed_at"].date
        self.commentsCount = jsonDict["comments"].int ?? 0
        self.issueNumber = jsonDict["number"].int ?? 0
    }
    
    /// The issues's created unique id. This is used for displaying the issue in a list.
    let id = UUID()
    
    /// The title of the issue.
    let title: String?
    
    ///The issue's body.
    let body: String?
    
    /// The issue's owner.
    let owner: ProfileUser?
    
    /// The issue's creation date.
    let creationDate: Date?
    
    ///The issue's close date.
    let closedDate: Date?
    
    ///The issue's total comments.
    let commentsCount: Int?
    
    ///The number (ID) of the issue on GitHub.
    let issueNumber: Int?
}
