import Foundation
import SwiftyJSON

struct Commit: Identifiable {
    init(message: String? = nil, owner: ProfileUser? = nil, date: Date? = nil) {
        self.message = message
        self.owner = owner
        self.date = date
    }
    
    init(dict: [String: Any]) {
        let jsonDict = JSON(dict)
        if let owner = jsonDict["committer"].dictionaryObject {
            self.owner = ProfileUser(dict: owner)
        } else {
            self.owner = nil
        }
        self.date = jsonDict["commit"]["committer"]["date"].date
        self.message = jsonDict["commit"]["message"].string
    }

    /// The commits's created unique id. This is used for displaying the commits in a list.
    var id = UUID()
    
    /// The commit's message.
    var message: String?
    
    /// The person orginally make changes on code.
    var owner: ProfileUser?
    
    /// The commit's data.
    var date: Date?
}
