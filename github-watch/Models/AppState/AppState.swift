import SwiftUI

class AppState: ObservableObject, Equatable, Encodable, Decodable {
    static func == (lhs: AppState, rhs: AppState) -> Bool {
        return lhs.user.accessToken == rhs.user.accessToken
    }
    
    init() {
        if let userData = UserDefaults.standard.object(forKey:  "user") {
            if let myData = try? JSONDecoder().decode(User.self, from: userData as! Data) {
                self.user = myData
            }
        }
    }
    
    @Published var user = User() {
        didSet {
            if let encodedUser = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(encodedUser, forKey: "user")
            }   
        }
    }
    
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user = try values.decode(User.self, forKey: .user)
    }
    
    enum CodingKeys: String, CodingKey {
        case user
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(user, forKey: .user)
    }
}
