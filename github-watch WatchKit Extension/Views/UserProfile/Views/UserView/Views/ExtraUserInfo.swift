import SwiftUI

struct ExtraUserInfo: View {
    let profileUser: ProfileUser

    init(profileUser: ProfileUser) {
        self.profileUser = profileUser
    }

    var body: some View {
        VStack {
            if let publicRepoCount = profileUser.publicRepoCount {
                HStack {
                    Text("Public repos:")
                        .font(Font.system(size: 11))
                        .foregroundColor(.gray)
                    Text("\(publicRepoCount)")
                        .font(Font.system(size: 11))
                        .bold()
                    Spacer()
                }.padding(.bottom, 2)
            }
            if let privateRepoCount = profileUser.privateRepoCount {
                HStack {
                    Text("Private repos:")
                        .font(Font.system(size: 11))
                        .foregroundColor(.gray)
                    Text("\(privateRepoCount)")
                        .font(Font.system(size: 11))
                        .bold()
                    Spacer()
                }.padding(.bottom, 2)
            }
            if let email = profileUser.email {
                HStack {
                    Text("Email:")
                        .font(Font.system(size: 11))
                        .foregroundColor(.gray)

                    Text("\(email)")
                        .font(Font.system(size: 11))
                        .bold()
                    Spacer()
                }.padding(.bottom, 2)
            }
            if let company = profileUser.company {
                HStack {
                    Text("Company:")
                        .font(Font.system(size: 11))
                        .foregroundColor(.gray)

                    Text("\(company)")
                        .font(Font.system(size: 11))
                        .bold()
                    Spacer()
                }.padding(.bottom, 2)
            }
            if let location = profileUser.location {
                HStack {
                    Text("Location:")
                        .font(Font.system(size: 11))
                        .foregroundColor(.gray)
                    Text("\(location)")
                        .font(Font.system(size: 11))
                        .bold()
                    Spacer()
                }.padding(.bottom, 2)
            }
        }
    }
}

struct ExtraUserInfo_Previews: PreviewProvider {
    static var previews: some View {
        ExtraUserInfo(profileUser: ProfileUser(username: "iberatkaya", name: "Ibrahim Berat Kaya", bio: "I\'m interested in Flutter, Node.js, React Native, React.js, Swift & SwiftUI, Express.js, and Rust.", avatarUrl: "https://avatars.githubusercontent.com/u/34488374?v=4", email: "beratkaya1998@gmail.com", followers: 23, following: 21, company: "ITU", publicRepoCount: 38, privateRepoCount: 24, location: "Istanbul", userType: "User"))
    }
}
