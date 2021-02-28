import SwiftUI
import URLImage

struct UserView: View {
    var profileUser: ProfileUser
    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            // User info and profile image
            VStack {
                if let urlStr = profileUser.avatarUrl {
                    UserImage(url: urlStr)
                        .padding(.bottom, 8)
                }
                if let name = profileUser.name {
                    Text(name)
                        .bold()
                        .font(Font.system(size: 14))
                        .padding(.bottom, 2)
                }
                
                if let username = profileUser.username {
                    Text("@\(username)")
                        .foregroundColor(.gray)
                        .font(Font.system(size: 11))
                        .padding(.bottom, 2)
                }
                
                if let username = profileUser.username, profileUser.userType != UserType.organization {
                    FollowStatView(
                        followers: profileUser.followers ?? 0,
                        following: profileUser.following ?? 0,
                        username: username).padding(.bottom, 4)
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
            ExtraUserInfo(profileUser: profileUser).padding(.bottom, 6)
            
            if let username = profileUser.username {
                if profileUser.userType != UserType.organization {
                    NavigationLink(destination: OrganizationsList(organizationViewModel: RealOrganizationViewModel(appState: appState), username: username)) {
                        Text("Organizations")
                    }
                }
                NavigationLink(destination: UserRepos(repoViewModel: RealRepoViewModel(appState: appState), username: username)) {
                    Text("View Repos")
                }
            }
        }.padding(.horizontal, 6)
    }
}

struct UserView_Previews: PreviewProvider {
    static var profileUser1 = ProfileUser(username: "iberatkaya", name: "Ibrahim Berat Kaya", bio: "I\'m interested in Flutter, Node.js, React Native, React.js, Swift & SwiftUI, Express.js, and Rust.", avatarUrl: "https://avatars.githubusercontent.com/u/34488374?v=4", email: "beratkaya1998@gmail.com", followers: 23, following: 21, company: "ITU", publicRepoCount: 38, privateRepoCount: 24, location: "Istanbul", userType: "User")
    
    static var profileUser2 = ProfileUser(username: "flutter", name: "Flutter", bio: nil, avatarUrl: "https://avatars.githubusercontent.com/u/14101776?v=4", email: nil, followers: 0, following: 0, company: nil, publicRepoCount: 34, location: nil, userType: "Organization")
    
    static var previews: some View {
        ScrollView {
            UserView(profileUser: profileUser2).environmentObject(AppState())
        }
    }
}
