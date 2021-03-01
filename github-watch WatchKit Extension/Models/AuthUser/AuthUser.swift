struct AuthUser: Encodable, Decodable {
    init(accessToken: String? = nil, username: String? = nil) {
        self.accessToken = accessToken
    }
    
    /// The access token of the user.
    var accessToken: String?
    
    /// The username of the user.
    var username: String?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try values.decode(String.self, forKey: .accessToken)
        username = try values.decode(String.self, forKey: .username)
    }
    
    enum CodingKeys: String, CodingKey {
        case accessToken, username
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(accessToken, forKey: .accessToken)
        try container.encode(username, forKey: .username)
    }
}
