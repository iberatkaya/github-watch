import SwiftUI

struct UserProfile: View {
    @EnvironmentObject var profileInteractor: RealProfileInteractor
    @EnvironmentObject var appState: AppState
    @State var profileUser: ProfileUser?
    @State var loading = false
    var username: String = ""
    
    init(username: String) {
        self.username = username
    }
    
    var body: some View {
        ScrollView {
            if(loading){
                ProgressView()
            }
            UserView(profileUser: profileUser)
        }
        .onAppear(perform: {
            profileInteractor.requestProfile(username: username, completed: { pUser in
                loading = false
                if let pUser = pUser {
                    profileUser = pUser
                }
            })
        })
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile(username: "test")
    }
}
