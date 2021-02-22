import SwiftUI

struct Home: View {
    @EnvironmentObject var authInteractor: RealAuthInteractor
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ScrollView {
            Text("User has access token: " + (appState.user.accessToken ?? "false"))
                .padding()
            if(appState.user.accessToken == nil){
                NavigationLink(destination: GitHubAuth().environmentObject(authInteractor)){
                    Text("Click me!")
                }
            } else {
                Button("Sign Out", action: {
                    authInteractor.signOut()
                })
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
