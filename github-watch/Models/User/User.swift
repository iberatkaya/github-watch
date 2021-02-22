struct User: Encodable, Decodable {
    init(accessToken: String? = nil) {
        self.accessToken = accessToken
    }
    
    var accessToken: String?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try values.decode(String.self, forKey: .accessToken)
    }
    
    enum CodingKeys: String, CodingKey {
        case accessToken
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(accessToken, forKey: .accessToken)
    }
}
