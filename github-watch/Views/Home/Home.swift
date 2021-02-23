import SwiftUI

struct Home: View {
    @EnvironmentObject var authInteractor: RealAuthInteractor
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var connectivityController: ConnectivityController
    
    var body: some View {
        ScrollView {
            if(appState.user.accessToken == nil){
                NavigationLink(destination: GitHubAuth()
                                .environmentObject(authInteractor)
                                .environmentObject(connectivityController)){
                    Text("Login To GitHub!").bold()
                }
            } else {
                Text("You are logged in")
                    .padding()
                Button("Sign Out", action: {
                    authInteractor.signOut()
                })
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home().environmentObject(AppState())
    }
}
