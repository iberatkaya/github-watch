import SwiftUI

struct UserProfile: View {
    @ObservedObject var profileViewModel: RealProfileViewModel
    let username: String

    init(profileViewModel: RealProfileViewModel, username: String) {
        self.username = username
        self.profileViewModel = profileViewModel
    }

    var body: some View {
        ScrollView {
            if profileViewModel.loading {
                ProgressView()
            }
            if let profileUser = profileViewModel.profileUser {
                UserView(profileUser: profileUser)
            } else if !profileViewModel.loading {
                Text("User \(username) cound not be found!")
            }
            if let error = profileViewModel.error {
                Text(error).padding(.horizontal, 4)
            }
        }
        .navigationTitle(username)
        .padding(.horizontal, 2)
        .onAppear(perform: {
            profileViewModel.requestProfile(username: username)
        })
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile(profileViewModel: RealProfileViewModel(appState: AppState()), username: "test")
            .environmentObject(AppState())
    }
}
