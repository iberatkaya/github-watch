import SwiftUI

struct Home: View {
    @EnvironmentObject var authInteractor: RealAuthInteractor
    @EnvironmentObject var appState: AppState
    
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
                    NavigationLink(destination: UserProfile(username: username)) {
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
                
                Button("Sign Out", action: {
                    authInteractor.signOut()
                })
            }
        }.padding(.horizontal, 2)
    }
}

struct Home_Previews: PreviewProvider {
    static var appState = AppState()
    
    static var previews: some View {
        Home().environmentObject(appState).environmentObject(RealAuthInteractor(appState: appState))
    }
}
