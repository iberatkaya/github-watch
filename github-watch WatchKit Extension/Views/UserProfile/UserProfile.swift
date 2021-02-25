import SwiftUI

struct UserProfile: View {
    @EnvironmentObject var profileInteractor: RealProfileInteractor
    @EnvironmentObject var appState: AppState
    @State var profileUser: ProfileUser?
    @State var loading = true
    @State var error: String?
    let username: String

    init(username: String) {
        self.username = username
    }

    var body: some View {
        ScrollView {
            if loading {
                ProgressView()
            }
            if let profileUser = profileUser {
                UserView(profileUser: profileUser)
            } else if !loading {
                Text("User \(username) cound not be found!")
            }
            if let error = error {
                Text(error).padding(.horizontal, 4)
            }
        }
        .navigationTitle(username)
        .padding(.horizontal, 2)
        .onAppear(perform: {
            profileInteractor.requestProfile(username: username, completed: { pUser in
                profileUser = pUser
                loading = false
                error = nil
            }, onError: { err in
                DispatchQueue.main.async {
                    loading = false
                    error = err
                }
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
