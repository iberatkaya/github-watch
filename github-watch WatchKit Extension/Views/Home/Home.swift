import FASwiftUI
import SwiftUI

struct Home: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var authViewModel: RealAuthViewModel
    
    init(authViewModel: RealAuthViewModel) {
        self.authViewModel = authViewModel
    }
    
    var body: some View {
        ScrollView {
            if appState.user.accessToken == nil {
                VStack {
                    Text("Please sign in to GitHub from Git Watch's iPhone App! If an error occurred, please resend the OAuth Token.")
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.system(size: 11))
                        .padding(.bottom, 12)
                    
                    ProgressView()
                }.padding(.horizontal, 8)
            }
            else {
                if let username = appState.user.username {
                    NavigationLink(destination: UserProfile(profileViewModel: RealProfileViewModel(appState: appState), username: username)) {
                        HStack {
                            FAText(iconName: "user-circle", size: 13, style: FAStyle.solid)
                                .padding(.trailing, 4)
                            Text("@\(username)").font(.system(size: 13))
                            Spacer()
                        }
                    }
                }
                
                Divider().padding(.vertical, 2)
                
                NavigationLink(destination: SearchRepos()) {
                    HStack {
                        FAText(iconName: "folder", size: 13, style: FAStyle.solid)
                            .padding(.trailing, 4)
                        Text("Search For Repos").font(.system(size: 13))
                        Spacer()
                    }
                }
                
                Divider().padding(.vertical, 2)
                
                NavigationLink(destination: SearchUsers()) {
                    HStack {
                        FAText(iconName: "user", size: 13, style: FAStyle.solid)
                            .padding(.trailing, 4)
                        Text("Search For Users").font(.system(size: 13))
                        Spacer()
                    }
                }
                
                Divider().padding(.vertical, 2)
                
                NavigationLink(destination: About()) {
                    HStack {
                        FAText(iconName: "question-circle", size: 13, style: FAStyle.solid)
                            .padding(.trailing, 4)
                        Text("About").font(.system(size: 13))
                        Spacer()
                    }
                }
                
                Divider().padding(.vertical, 2)
                
                Button(action: {
                    authViewModel.signOut()
                }, label: {
                    HStack {
                        FAText(iconName: "sign-out-alt", size: 13, style: FAStyle.solid)
                            .padding(.trailing, 4)
                        Text("Sign Out")
                        Spacer()
                    }
                }).font(.system(size: 13))
            }
        }.padding(.horizontal, 2)
    }
}

struct Home_Previews: PreviewProvider {
    static var appState = AppState()
    
    static var previews: some View {
        Home(authViewModel: RealAuthViewModel(appState: appState)).environmentObject(appState)
    }
}
