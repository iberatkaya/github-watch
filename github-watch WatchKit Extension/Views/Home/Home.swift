import SwiftUI

struct Home: View {
    @EnvironmentObject var profileInteractor: RealProfileInteractor
    @EnvironmentObject var authInteractor: RealAuthInteractor
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ScrollView {
            if(appState.user.accessToken == nil){
                Text("Please sign in to your GitHub account from your iPhone!")
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                ProgressView()
            }
            else {
                Text(appState.user.username ?? "User").padding()
                NavigationLink(destination: ViewUser().environmentObject(appState).environmentObject(profileInteractor)){
                    Text("View User")
                }
                Button("Sign Out", action: {
                    authInteractor.signOut()
                })
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var appState = AppState()
    
    static var previews: some View {
        Home().environmentObject(appState)
    }
}
