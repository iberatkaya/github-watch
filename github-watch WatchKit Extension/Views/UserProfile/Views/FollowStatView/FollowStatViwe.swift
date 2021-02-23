import SwiftUI

struct FollowStatView: View {
    let followers: Int
    let following: Int

    init(followers: Int, following: Int) {
        self.followers = followers
        self.following = following
    }

    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("Followers")
                    .foregroundColor(.gray)
                    .font(.system(size: 10))
                Text("\(followers.roundedWithAbbreviations)")
                    .font(.system(size: 14))
                    .bold()
            }
            Spacer()
            VStack {
                Text("Followings")
                    .foregroundColor(.gray)
                    .font(.system(size: 10))
                Text("\(following.roundedWithAbbreviations)")
                    .font(.system(size: 14))
                    .bold()
            }
            Spacer()
        }
    }
}

struct FollowStatView_Previews: PreviewProvider {
    static var previews: some View {
        FollowStatView(followers: 324234, following: 234234)
    }
}
