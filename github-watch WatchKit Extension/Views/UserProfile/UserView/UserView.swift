import SwiftUI
import URLImage

struct UserView: View {
    var profileUser: ProfileUser?
    
    var body: some View {
        VStack {
            if let urlStr = profileUser?.avatarUrl, let url = URL(string: urlStr) {
                URLImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill() // <=== Saves aspect ratio
                        .frame(width: 120.0, height: 120)
                        .clipShape(Circle())
                }
                .cornerRadius(12)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
            }
            Text(profileUser?.name ?? "")
                .bold()
                .font(Font.system(size: 14))
                .padding(EdgeInsets(top: 0, leading: 4, bottom: 4, trailing: 4))
            Text(profileUser?.bio ?? "")
                .font(Font.system(size: 12))
                .padding(EdgeInsets(top: 0, leading: 6, bottom: 4, trailing: 6))
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var profileUser = ProfileUser(login: "iberatkaya", name: "Ibrahim Berat Kaya", bio: "I\'m interested in Flutter, Node.js, React Native, React.js, Swift & SwiftUI, Express.js, and Rust.", avatarUrl: "https://avatars.githubusercontent.com/u/34488374?v=4", email: nil, followers: 23, following: 21)
    
    static var previews: some View {
        ScrollView {
            UserView(profileUser: profileUser)
        }
    }
}
