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
                    Text("Please sign in to your GitHub account from your iPhone!")
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, 8)
                    ProgressView()
                }.padding(.horizontal, 8)
            }
            else {
                if let username = appState.user.username {
                    NavigationLink(destination: UserProfile(profileViewModel: RealProfileViewModel(appState: appState), username: username)) {
                        Text("@\(username)")
                    }
                }
                
                Divider().padding(.vertical, 2)
                
                NavigationLink(destination: ViewUser()) {
                    Text("View User")
                }
                
                Divider().padding(.vertical, 2)
                
                NavigationLink(destination: SearchRepos()) {
                    Text("Search For Repos")
                }
                
                Divider().padding(.vertical, 2)
                
                
                NavigationLink(destination: SearchUsers()) {
                    Text("Search For Users")
                }
                
                Divider().padding(.vertical, 2)
                
                Button("Sign Out", action: {
                    authViewModel.signOut()
                })
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
