import SwiftUI
import URLImage

struct UserView: View {
    var profileUser: ProfileUser
    
    var body: some View {
        VStack {
            //User info and profile image
            VStack {
                if let urlStr = profileUser.avatarUrl, let url = URL(string: urlStr) {
                    URLImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120.0, height: 120)
                            .clipShape(Circle())
                    }
                    .cornerRadius(12)
                    .padding(.bottom, 8)
                }
                if let name = profileUser.name {
                    Text(name)
                        .bold()
                        .font(Font.system(size: 14))
                        .padding(.bottom, 2)
                }
                if let username = profileUser.login {
                    Text("@\(username)")
                        .foregroundColor(.gray)
                        .font(Font.system(size: 11))
                        .padding(.bottom, 2)
                }
                HStack {
                    Spacer()
                    VStack {
                        Text("Followers")
                            .foregroundColor(.gray)
                            .font(.system(size: 10))
                        Text("\(profileUser.followers ?? 0)")
                            .font(.system(size: 14))
                            .bold()
                    }
                    Spacer()
                    VStack {
                        Text("Followings")
                            .foregroundColor(.gray)
                            .font(.system(size: 10))
                        Text("\(profileUser.following ?? 0)")
                            .font(.system(size: 14))
                            .bold()
                    }
                    Spacer()
                }.padding(.bottom, 4)
            }.padding(.horizontal, 4)
            
            Divider().padding(.bottom, 2)
            
            //User bio
            VStack {
                if let bio = profileUser.bio {
                    Text("Bio")
                        .bold()
                        .padding(.bottom, 2)
                    Text(bio)
                        .font(Font.system(size: 12))
                        .foregroundColor(.gray)
                    
                    
                }
            }.padding(EdgeInsets(top: 0, leading: 6, bottom: 4, trailing: 6))
            
            Divider().padding(.bottom, 2)
            
            //Extra info
            VStack {
                if let repoCount = profileUser.repoCount {
                    HStack {
                        Text("Public repos:")
                            .font(Font.system(size: 11))
                            .foregroundColor(.gray)
                        Text("\(repoCount)")
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
            }.padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 16))
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var profileUser = ProfileUser(login: "iberatkaya", name: "Ibrahim Berat Kaya", bio: "I\'m interested in Flutter, Node.js, React Native, React.js, Swift & SwiftUI, Express.js, and Rust.", avatarUrl: "https://avatars.githubusercontent.com/u/34488374?v=4", email: "beratkaya1998@gmail.com", followers: 23, following: 21, company: "ITU", repoCount: 38, location: "Istanbul")
    
    static var previews: some View {
        ScrollView {
            UserView(profileUser: profileUser)
        }
    }
}
