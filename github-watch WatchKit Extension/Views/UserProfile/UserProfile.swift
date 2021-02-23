import SwiftUI

struct UserProfile: View {
    @EnvironmentObject var profileInteractor: RealProfileInteractor
    @EnvironmentObject var appState: AppState
    @State var profileUser: ProfileUser?
    @State var loading = true
    let username: String
    
    init(username: String) {
        self.username = username
    }
    
    var body: some View {
        ScrollView {
            if(loading){
                ProgressView()
            }
            if let profileUser = profileUser {
                UserView(profileUser: profileUser)
                NavigationLink(destination: UserRepos(username: username)){
                    Text("View Repos")
                }
            } else if(!loading){
                Text("User \(username) cound not be found!")
            }
        }
        .onAppear(perform: {
            profileInteractor.requestProfile(username: username, completed: { pUser in
                if let pUser = pUser {
                    print(pUser)
                    profileUser = pUser
                }
                loading = false
            })
        })
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile(username: "test")
            .environmentObject(AppState())
            .environmentObject(RealProfileInteractor(appState: AppState()))
    }
}
