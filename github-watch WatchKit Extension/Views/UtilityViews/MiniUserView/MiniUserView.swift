import SwiftUI

struct MiniUserView: View {
    let user: ProfileUser

    var body: some View {
        ScrollView {
            if let avatarUrl = user.avatarUrl {
                UserImage(url: avatarUrl, width: 60, height: 60).padding(.bottom, 2)
            }
            if let name = user.name {
                Text(name)
                    .bold()
                    .font(.system(size: 15))
            }
            if let username = user.username {
                Text("@" + username)
                    .bold()
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                    .padding(.bottom, 2)
            }
            if let bio = user.bio {
                Text(bio)
                    .font(.system(size: 11))
                    .lineLimit(2)
                    .foregroundColor(.gray)
                    .padding(.bottom, 4)
            }

        }.padding(.horizontal, 2)
    }
}

struct MiniUserView_Previews: PreviewProvider {
    static var previews: some View {
        MiniUserView(user: ProfileUser(username: "testuser", name: "Test User", bio: "This is a test user bio", avatarUrl: "https://avatars.githubusercontent.com/u/62440653?v=4"))
    }
}
