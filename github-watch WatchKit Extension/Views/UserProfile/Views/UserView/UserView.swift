import SwiftUI
import URLImage

struct UserView: View {
    var profileUser: ProfileUser
    
    var body: some View {
        VStack {
            // User info and profile image
            VStack {
                if let urlStr = profileUser.avatarUrl, let url = URL(string: urlStr) {
                    URLImage(url: url,
                             inProgress: { progress -> Text in // Display progress
                                 if let progress = progress {
                                     return Text(String(format: "%.0f", progress) + "%")
                                 }
                                 else {
                                     return Text("Loading...")
                                 }
                             },
                             failure: { error, retry in // Display error and retry button
                                 VStack {
                                     Text(error.localizedDescription)
                                     Button("Retry", action: retry)
                                 }
                             },
                             content: { image in
                                 image
                                     .resizable()
                                     .scaledToFill()
                                     .frame(width: 120.0, height: 120)
                                     .clipShape(Circle())
                             })
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
                
                if profileUser.userType != "Organization" {
                    FollowStatView(followers: profileUser.followers ?? 0, following: profileUser.following ?? 0).padding(.bottom, 4)
                }
                else {
                    Text("Organization").foregroundColor(.gray)
                        .font(Font.system(size: 11))
                        .padding(.bottom, 4)
                }
            }
            
            Divider().padding(.bottom, 4)
            
            // User bio
            VStack {
                if let bio = profileUser.bio {
                    Text("Bio")
                        .bold()
                        .padding(.bottom, 2)
                    Text(bio)
                        .font(Font.system(size: 12))
                        .foregroundColor(.gray)
                        .padding(.bottom, 2)
                    Divider().padding(.bottom, 4)
                }
            }
            
            // Extra info
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
            }.padding(.bottom, 6)
            
            if let username = profileUser.login {
                NavigationLink(destination: UserRepos(username: username)) {
                    Text("View Repos")
                }
            }
        }.padding(.horizontal, 6)
    }
}

struct UserView_Previews: PreviewProvider {
    static var profileUser1 = ProfileUser(login: "iberatkaya", name: "Ibrahim Berat Kaya", bio: "I\'m interested in Flutter, Node.js, React Native, React.js, Swift & SwiftUI, Express.js, and Rust.", avatarUrl: "https://avatars.githubusercontent.com/u/34488374?v=4", email: "beratkaya1998@gmail.com", followers: 23, following: 21, company: "ITU", publicRepoCount: 38, privateRepoCount: 24, location: "Istanbul", userType: "User")
    
    static var profileUser2 = ProfileUser(login: "flutter", name: "Flutter", bio: nil, avatarUrl: "https://avatars.githubusercontent.com/u/14101776?v=4", email: nil, followers: 0, following: 0, company: nil, publicRepoCount: 34, location: nil, userType: "Organization")
    
    static var previews: some View {
        ScrollView {
            UserView(profileUser: profileUser2)
        }
    }
}
