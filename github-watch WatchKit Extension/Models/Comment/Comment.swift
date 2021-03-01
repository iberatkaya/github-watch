import Foundation
import SwiftyJSON

struct Comment: Identifiable {
    init(body: String? = nil, owner: ProfileUser? = nil, creationDate: Date? = nil) {
        self.body = body
        self.owner = owner
        self.creationDate = creationDate
    }
    
    init(dict: [String: Any]) {
        let jsonDict = JSON(dict)
        self.body = jsonDict["body"].string ?? ""
        if let user = jsonDict["user"].dictionaryObject {
            self.owner = ProfileUser(dict: user)
        }
        else {
            self.owner = nil
        }
        self.creationDate = jsonDict["created_at"].date
    }
    
    /// The issues's created unique id. This is used for displaying the issue in a list.
    let id = UUID()
    
    /// The comment's body.
    let body: String?
    
    /// The comment's owner.
    let owner: ProfileUser?
    
    /// The comment's creation date.
    let creationDate: Date?
}
