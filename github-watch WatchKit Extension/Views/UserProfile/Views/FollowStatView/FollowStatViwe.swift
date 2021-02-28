import SwiftUI

struct FollowStatView: View {
    @EnvironmentObject var appState: AppState
    let followers: Int
    let following: Int
    let username: String

    init(followers: Int, following: Int, username: String) {
        self.followers = followers
        self.following = following
        self.username = username
    }

    var body: some View {
        HStack {
            Spacer()
            NavigationLink(
                destination: UsersList(usersViewModel: RealUsersViewModel(appState: appState), username: username, userFollowType: UserFollowType.followers)
            ) {
                VStack {
                    Text("Followers")
                        .foregroundColor(.gray)
                        .font(.system(size: 8))
                    Text("\(followers.roundedWithAbbreviations)")
                        .font(.system(size: 14))
                        .bold()
                }
            }
            Spacer()
            NavigationLink(
                destination: UsersList(usersViewModel: RealUsersViewModel(appState: appState), username: username, userFollowType: UserFollowType.following)
            ) {
                VStack {
                    Text("Followings")
                        .foregroundColor(.gray)
                        .font(.system(size: 8))
                    Text("\(following.roundedWithAbbreviations)")
                        .font(.system(size: 14))
                        .bold()
                }
            }
            Spacer()
        }
    }
}

struct FollowStatView_Previews: PreviewProvider {
    static var previews: some View {
        FollowStatView(followers: 324234, following: 234234, username: "iberatkaya")
    }
}
